package com.javaweb.controller.admin;



import com.javaweb.enums.districtCode;
import com.javaweb.enums.typeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.BuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController(value="buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private BuildingService buildingService;

    @Autowired
    IUserService userService;

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@RequestParam Map<String, Object> requestParam,
                                     @RequestParam(value = "typeCode", required = false) List<String> typeCodes,
                                     @ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest,
                                     HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("districtCode", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());

        DisplayTagUtils.of(request, buildingSearchRequest);
        Pageable pageable = PageRequest.of(buildingSearchRequest.getPage() - 1, buildingSearchRequest.getMaxPageItems());
        List<BuildingSearchResponse> result = new ArrayList<>();
        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            requestParam.put("staffId", staffId);
            result = buildingService.findAll(requestParam, typeCodes, pageable);
        }
        else{
            result = buildingService.findAll(requestParam, typeCodes, pageable);
        }
        BuildingSearchResponse buildingSearchResponse = new BuildingSearchResponse();
        buildingSearchResponse.setListResult(result);
        buildingSearchResponse.setTotalItems(buildingService.countTotalItems(requestParam, typeCodes));
        mav.addObject("buildingList", buildingSearchResponse);
        mav.addObject("result", result);
        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView addBuilding(@ModelAttribute("buildingEdit") BuildingDTO buildingDTO){
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("districtCode", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView addBuilding(@PathVariable Long id){
        ModelAndView mav = new ModelAndView("admin/building/edit");

        BuildingDTO buildingDTO = buildingService.prepareBuildingEditData(id);

        Map<String, String> typeCodesMap = typeCode.getTypeCode();

        mav.addObject("districtCode", districtCode.district());
        mav.addObject("typeCodes", typeCodesMap);
        mav.addObject("buildingEdit", buildingDTO);

        return mav;
    }
}
