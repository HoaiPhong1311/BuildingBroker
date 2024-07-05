package com.javaweb.service.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.converter.BuildingConverter;
import com.javaweb.converter.BuildingSearchBuilderConverter;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.RentAreaRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.repository.entity.BuildingEntity;
import com.javaweb.repository.entity.RentAreaEntity;
import com.javaweb.service.BuildingService;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BuildingServiceImpl implements BuildingService {

    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private BuildingSearchBuilderConverter buildingSearchBuilderConverter;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    UploadFileUtils uploadFileUtils;

    @Override
    public List<BuildingSearchResponse> findAll(Map<String, Object> requestParam, List<String> typeCode, Pageable pageable) {
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(requestParam, typeCode);
        List<BuildingEntity> buildingEntities = buildingRepository.findAllBuildings(buildingSearchBuilder, pageable);
        List<BuildingSearchResponse> result = new ArrayList<BuildingSearchResponse>();

        for (BuildingEntity item : buildingEntities) {
            BuildingSearchResponse building = buildingConverter.toBuildingSearchResponse(item);

            result.add(building);
        }

        return result;
    }

    @Override
    @Transactional
    public void deleteBuilding(Long[] ids) {
        List<Long> idList = Arrays.asList(ids);

        buildingRepository.deleteByIdIn(idList);
    }

    @Override
    @Transactional
    public ResponseDTO assignBuildingToStaff(AssignmentBuildingDTO assignmentBuildingDTO) {
        Long buildingId = assignmentBuildingDTO.getBuildingId();
        List<Long> staffIds = assignmentBuildingDTO.getStaffs();

        BuildingEntity buildingEntity = buildingRepository.findById(buildingId).get();

        List<UserEntity> staffMembers = userRepository.findByIdIn(staffIds);

        buildingEntity.setUser(staffMembers);

        buildingRepository.save(buildingEntity);

        ResponseDTO response = new ResponseDTO();
        response.setMessage("Giao tòa nhà thành công");
        return response;
    }

    public BuildingDTO getBuildingDetails(Long buildingId){
        BuildingEntity building = buildingRepository.findById(buildingId).get();
        BuildingDTO buildingDTO = modelMapper.map(building, BuildingDTO.class);
        List<String> selectedTypeCodes = Arrays.asList(building.getTypeCode().split(","));
        buildingDTO.setTypeCode(selectedTypeCodes);

        String rentAreas = building.getRentAreas().stream()
                .map(rentArea -> String.valueOf(rentArea.getValue()))
                .collect(Collectors.joining(","));
        buildingDTO.setRentArea(rentAreas);
        return buildingDTO;
    }

    @Override
    @Transactional
    public BuildingDTO prepareBuildingEditData(Long id) {
        BuildingDTO buildingDTO = getBuildingDetails(id);

        return buildingDTO;
    }


    @Override
    @Transactional
    public void saveOrUpdateBuilding(Long id, BuildingDTO buildingDTO) {
        BuildingEntity building;

        if (id == null) {
            building = buildingConverter.toBuildingEntity(buildingDTO);
        } else {
            building = buildingRepository.findById(id).get();
            BeanUtils.copyProperties(buildingDTO, building, "id", "image");
            String typeCodesString = buildingDTO.getTypeCode().stream().collect(Collectors.joining(","));
            building.setTypeCode(typeCodesString);
        }

        if (buildingDTO.getRentArea() != null && !buildingDTO.getRentArea().isEmpty()) {
            List<RentAreaEntity> rentAreas = new ArrayList<>();
            String[] rentAreaArr = buildingDTO.getRentArea().split(",");
            for (String rentArea : rentAreaArr) {
                Long rentAreaValue = Long.parseLong(rentArea.trim());
                RentAreaEntity rentAreaEntity = new RentAreaEntity();
                rentAreaEntity.setBuildingId(building);
                rentAreaEntity.setValue(rentAreaValue);
                rentAreas.add(rentAreaEntity);
            }
            building.setRentAreas(rentAreas);
        }

        if (buildingDTO.getImageName() != null && !buildingDTO.getImageName().isEmpty()) {
            String imagePath = "/building/" + buildingDTO.getImageName();
            building.setImage(imagePath);
        }

        saveThumbnail(buildingDTO, building);

        buildingRepository.save(building);
    }

    @Override
    public int countTotalItems(Map<String, Object> requestParam, List<String> typeCode) {
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(requestParam, typeCode);
        return buildingRepository.countTotalItem(buildingSearchBuilder);
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" + buildingDTO.getImageName();
        if (null != buildingDTO.getImageBase64()) {
            if (null != buildingEntity.getImage()) {
                if (!path.equals(buildingEntity.getImage())) {
                    File file = new File("C://home/office" + buildingEntity.getImage());
                    file.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setImage(path);
        }
    }


}
