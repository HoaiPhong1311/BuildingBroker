<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<c:url var="buildingAPI" value="/api/buildings"></c:url>
<html>
<head>
    <title>Danh sách tòa nhà</title>
</head>
<body>

    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Home</a>
                    </li>

                    <li>
                        <a href="#">UI &amp; Elements</a>
                    </li>
                    <li class="active">Content Sliders</li>
                </ul><!-- /.breadcrumb -->
            </div>

            <div class="page-content" style="font-family: Arial, Helvetica, sans-serif;">
                <div class="page-header">
                    <h1>Danh sách tòa nhà
                    </h1>
                </div><!-- /.page-header -->

                <div class="row">
                    <div class="col-xs-12">
                        <div class="widget-box">
                            <div class="widget-header">
                                <h4 class="widget-title">Tìm kiếm</h4>

                                <span class="widget-toolbar">
                                            <a href="#" data-action="reload">
                                                <i class="ace-icon fa fa-refresh"></i>
                                            </a>

                                            <a href="#" data-action="collapse">
                                                <i class="ace-icon fa fa-chevron-up"></i>
                                            </a>
                                        </span>
                            </div>

                            <div class="widget-body" style="display: block;">
                                <div class="widget-main">
                                    <form:form action="/admin/building-list" modelAttribute="modelSearch" method="GET" id="listForm">
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-6">
                                                        <label>Tên tòa nhà</label>
                                                            <%-- Day la kieu input theo html
                                                            <input type="text" class="form-control" name="name" value="${modelSearch.name}">
                                                            --%>
                                                            <%-- Day la kieu input theo form:form --%>
                                                        <form:input path="name" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label>Diện tích sàn</label>
                                                            <%-- <input type="number" class="form-control" name="floorArea" value="${modelSearch.floorArea}"> --%>
                                                        <form:input path="floorArea" class="form-control"></form:input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-2">
                                                        <label>Quận hiện có</label>
                                                        <%--<select class="form-control" name="district">
                                                            <option value="">---Chọn quận---</option>
                                                            <option value="QUAN_1">Quận 1</option>
                                                            <option value="QUAN_2">Quận 2</option>
                                                            <option value="QUAN_3">Quận 3</option>
                                                            <option value="QUAN_4">Quận 4</option>
                                                            <option value="QUAN_5">Quận 5</option>
                                                        </select>--%>

                                                        <form:select path="district" class="form-control">
                                                            <form:option value="" label="---Chọn quận---" ></form:option>
                                                            <form:options items="${districtCode}"></form:options>

<%--                                                            <form:option value="1" label="Quận 1" ></form:option>--%>
<%--                                                            <form:option value="2" label="Quận 2" ></form:option>--%>
<%--                                                            <form:option value="3" label="Quận 3" ></form:option>--%>
<%--                                                            <form:option value="4" label="Quận 4" ></form:option>--%>
                                                        </form:select>
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <label>Phường</label>
                                                        <form:input path="ward" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <label>Đường</label>
                                                        <form:input path="street" class="form-control"></form:input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-4">
                                                        <label>Số tầng hầm</label>
                                                        <form:input path="numberOfBasement" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label>Hướng</label>
                                                        <form:input path="direction" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label>Hạng</label>
                                                        <form:input path="level" class="form-control"></form:input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-3">
                                                        <label>Diện tích từ</label>
                                                        <form:input path="areaFrom" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label>Diện tích đến</label>
                                                        <form:input path="areaTo" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label>Giá thuê từ</label>
                                                        <form:input path="rentPriceFrom" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label>Giá thuê đến</label>
                                                        <form:input path="rentPriceTo" class="form-control"></form:input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-4">
                                                        <label>Tên quản lý</label>
                                                        <form:input path="managerName" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label>SĐT quản lý</label>
                                                        <form:input path="managerPhone" class="form-control"></form:input>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <security:authorize access="hasRole('MANAGER')">
                                                            <label>Nhân viên phụ trách</label>
                                                            <form:select path="staffId" class="form-control">
                                                                <form:option value="" label="---Chọn nhân viên---" ></form:option>
                                                                <form:options items="${staffs}"></form:options>
                                                            </form:select>
                                                        </security:authorize>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-6">
                                                        <form:checkboxes path="typeCode" items="${typeCodes}"></form:checkboxes>
<%--                                                        typeCode là lấy từ modelSearch, còn typeCodes là lấy từ enum--%>
<%--                                                        <label>--%>
<%--                                                            <input type="checkbox" name="typeCode" value="noi-that">Nội thất--%>
<%--                                                        </label>--%>
<%--                                                        <label>--%>
<%--                                                            <input type="checkbox" name="typeCode" value="nguyen-can">Nguyên căn--%>
<%--                                                        </label>--%>
<%--                                                        <label>--%>
<%--                                                            <input type="checkbox" name="typeCode" value="tang-tret">Tầng trệt--%>
<%--                                                        </label>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-6">
                                                        <button class="btn btn-sm btn-primary" id="btnSearch">
                                                            <i class="ace-icon glyphicon glyphicon-search"></i>
                                                            Tìm kiếm
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                        <div class="pull-right">
                            <security:authorize access="hasRole('MANAGER')">
                                <a href="/admin/building-edit">
                                    <button title="Thêm tòa nhà" class="btn btn-primary">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                             class="bi bi-building-add" viewBox="0 0 16 16">
                                            <path
                                                    d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0" />
                                            <path
                                                    d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                                            <path
                                                    d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
                                        </svg>
                                    </button>
                                </a>

                                <button title="Xóa tòa nhà" class="btn btn-danger" id="btnDeleteBuildings">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-building-dash" viewBox="0 0 16 16">
                                        <path
                                                d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1" />
                                        <path
                                                d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                                        <path
                                                d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
                                    </svg>
                                </button>
                            </security:authorize>
                        </div>
                    </div>
                </div><!-- /.row -->

                <div class="hr hr-18 dotted hr-double"></div>

                <div class="row">
                    <div class="col-xs-12">
                            <display:table name="buildingList.listResult" cellspacing="0" cellpadding="0"
                                           requestURI="/admin/building-list" partialList="true" sort="external"
                                           size="${buildingList.totalItems}" defaultsort="2" defaultorder="ascending"
                                           id="tableList" pagesize="${buildingList.maxPageItems}"
                                           export="false"
                                           class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                           style="margin: 3em 0 1.5em;">
                                <display:column title="<fieldset class='form-group'>
                                                    <input type = 'checkbox' id='checkAll' class = 'check-box-element'>
                                                    </fieldset>" class="center select-cell"
                                                headerClass="center select-cell">
                                    <fieldset>
                                        <input type="checkbox" name="checkList" value="${tableList.id}"
                                                id="checkbox_${tableList.id}" class="check-box-element" />
                                    </fieldset>
                                </display:column>
                                <display:column headerClass="text-left" property="name" title="Tên tòa nhà"/>
                                <display:column headerClass="text-left" property="address" title="Địa chỉ"/>
                                <display:column headerClass="text-left" property="numberOfBasement" title="Số tầng hầm"/>
                                <display:column headerClass="text-left" property="managerName" title="Tên quản lý"/>
                                <display:column headerClass="text-left" property="managerPhone" title="SĐT quản lý"/>
                                <display:column headerClass="text-left" property="floorArea" title="D.Tích sàn"/>
                                <display:column headerClass="text-left" property="emptyArea" title="D.Tích trống"/>
                                <display:column headerClass="text-left" property="rentArea" title="D.Tích thuê"/>
                                <display:column headerClass="text-left" property="rentPrice" title="Giá thuê"/>
                                <display:column headerClass="text-left" property="serviceFee" title="Phí dịch vụ"/>
                                <display:column headerClass="text-left" property="brokerageFee" title="Phí môi giới"/>
                                <display:column headerClass="col-actions" title="Thao tác">
                                    <security:authorize access="hasRole('MANAGER')">
                                        <button class="btn btn-sm btn-success" title="Giao tòa nhà"
                                                onclick="assignmentBuilding(${tableList.id})">
                                            <i class="ace-icon glyphicon glyphicon-align-justify"></i>
                                        </button>
                                    </security:authorize>
                                    <a class="btn btn-sm btn-info" title="Sửa tòa nhà" href="/admin/building-edit-${tableList.id}">
                                        <i class="ace-icon fa fa-pencil-square-o"></i>
                                    </a>
                                    <security:authorize access="hasRole('MANAGER')">
                                        <button class="btn btn-sm btn-danger" title="Xóa tòa nhà"
                                                onclick="btnDeleteBuilding(${tableList.id})">
                                            <i class="ace-icon fa fa-trash-o"></i>
                                        </button>
                                    </security:authorize>
                                </display:column>
                            </display:table>
                    </div>
                </div>
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->

    <div class="modal fade" id="assignmentBuildingModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Danh sách nhân viên</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered" id="staffList">
                        <thead>
                        <tr>
                            <th class="center">
                                Chọn
                            </th>
                            <th class="center">Tên Nhân Viên</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                    <input type="hidden" id="buildingId" name="buildingId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnAssignBuilding">Giao tòa nhà</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function assignmentBuilding(buildingId){
            $('#assignmentBuildingModal').modal();
            $('#buildingId').val(buildingId);
            loadStaffs(buildingId);
        }

        function loadStaffs(buildingId){
            $.ajax({
                type: "GET",
                url: "${buildingAPI}/" + buildingId + "/staffs",
                dataType: "json",
                success:(response) =>{
                    var row = '';
                    $.each(response.data, function (index, item){
                        row += '<tr>';
                        row += '<td class="center"><input type="checkbox" value="' + item.staffId + '" id="checkbox_' + item.staffId + '"  ' + item.checked + '> </td>';
                        row += '<td class="center">' + item.fullName + '</td>';
                        row += '</tr>';
                    });
                    $('#staffList tbody').html(row);
                },
                error: function(response){
                    console.log(response);
                },
            });
        }

        $('#btnAssignBuilding').click(function(e){
            e.preventDefault();
            var data = {};
            data['buildingId'] = $('#buildingId').val();
            var staffs = $('#staffList').find('tbody input[type = checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['staffs'] = staffs;

            $.ajax({
                type: "PUT",
                url: "${buildingAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: (response) =>{
                    alert("Giao tòa nhà thành công!!");
                },
                error: function(response){
                    alert("Giao tòa nhà không thành công!!");
                },
            });
        });

        $('#btnDeleteBuildings').click(function(e){
            e.preventDefault();
            var data = {};
            var buildingIds = $('#tableList').find('tbody tr fieldset input[type = checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['buildingIds'] = buildingIds;
            deleteBuilding(data);
        });

        function btnDeleteBuilding(buildingId){
            var data = {};
            data['buildingIds'] = buildingId;
            deleteBuilding(data);
        }

        function deleteBuilding(data){
            $.ajax({
                type: "DELETE",
                url: "${buildingAPI}/" + data['buildingIds'],
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "text",
                success:(response) =>{
                    alert(response);
                    window.location.replace("/admin/building-list")
                },
                error: function(response){
                    alert("Xóa không thành công!!");
                    console.log(response);
                },
            });
        }

        $('#btnSearch').click(function(e) {
            e.preventDefault();

            // Lấy dữ liệu form
            var formData = $('#listForm').serialize();

            // Submit form đến controller
            $('#listForm').attr('action', '/admin/building-list'); // Đặt action cho form
            $('#listForm').submit(); // Submit form
        });

    </script>

</body>
</html>
