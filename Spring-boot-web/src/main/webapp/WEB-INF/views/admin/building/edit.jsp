<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingEditURL" value="/admin/building-edit"></c:url>
<html>
<head>
    <title>Thông tin tòa nhà</title>
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
                    <h1>Thông tin tòa nhà
                    </h1>
                </div><!-- /.page-header -->

                <div class="row" style="font-family: Arial, Helvetica, sans-serif;">
                    <form:form modelAttribute="buildingEdit" action="${buildingEditURL}" method="get" id="form-edit">
                        <div class="col-xs-12">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Tên tòa nhà</label>
                                    <div class="col-xs-9">
                                        <form:input path="name" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name" id="district">Quận</label>
                                    <div class="col-xs-4">
                                        <form:select path="district" class="form-control">
                                            <form:option value="" label="---Chọn quận---" ></form:option>
                                            <form:options items="${districtCode}"></form:options>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phường</label>
                                    <div class="col-xs-9">
                                        <form:input path="ward" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Đường</label>
                                    <div class="col-xs-9">
                                        <form:input path="street" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Kết cấu</label>
                                    <div class="col-xs-9">
                                        <form:input path="structure" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Số tầng hầm</label>
                                    <div class="col-xs-9">
                                        <form:input path="numberOfBasement" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Diện tích sàn</label>
                                    <div class="col-xs-9">
                                        <form:input path="floorArea" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Hướng</label>
                                    <div class="col-xs-9">
                                        <form:input path="direction" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Hạng</label>
                                    <div class="col-xs-9">
                                        <form:input path="level" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Diện tích thuê</label>
                                    <div class="col-xs-9">
                                        <form:input path="rentArea" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name" id="rentAreas">Giá thuê</label>
                                    <div class="col-xs-9">
                                        <form:input path="rentPrice" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Mô tả giá</label>
                                    <div class="col-xs-9">
                                        <form:input path="rentPriceDescription" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phí dịch vụ</label>
                                    <div class="col-xs-9">
                                        <form:input path="serviceFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phí ô tô</label>
                                    <div class="col-xs-9">
                                        <form:input path="carFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phí mô tô</label>
                                    <div class="col-xs-9">
                                        <form:input path="motoFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phí ngoài giờ</label>
                                    <div class="col-xs-9">
                                        <form:input path="overtimeFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Tiền điện</label>
                                    <div class="col-xs-9">
                                        <form:input path="electricityFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Tiền nước</label>
                                    <div class="col-xs-9">
                                        <form:input path="waterFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Đặt cọc</label>
                                    <div class="col-xs-9">
                                        <form:input path="deposit" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Thanh toán</label>
                                    <div class="col-xs-9">
                                        <form:input path="payment" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Thời hạn thuê</label>
                                    <div class="col-xs-9">
                                        <form:input path="rentTime" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Thời gian trang trí</label>
                                    <div class="col-xs-9">
                                        <form:input path="decorationTime" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Tên quản lý</label>
                                    <div class="col-xs-9">
                                        <form:input path="managerName" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">SĐT quản lý</label>
                                    <div class="col-xs-9">
                                        <form:input path="managerPhone" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Loại tòa nhà</label>
                                    <div class="col-xs-9">
<%--                                        <form:checkbox path="typeCode"></form:checkbox>--%>
                                        <form:checkboxes path="typeCode" items="${typeCodes}"></form:checkboxes>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Phí môi giới</label>
                                    <div class="col-xs-9">
                                        <form:input path="brokerageFee" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" for="name">Ghi chú</label>
                                    <div class="col-xs-9">
                                        <form:input path="note" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 no-padding-right">Hình đại diện</label>
                                    <input class="col-sm-3 no-padding-right" type="file" id="uploadImage"/>
                                    <div class="col-sm-9">
                                        <c:if test="${not empty buildingEdit.image}">
                                            <c:set var="imagePath" value="/repository${buildingEdit.image}"/>
                                            <img src="${imagePath}" id="viewImage" width="300px" height="300px" style="margin-top: 50px">
                                        </c:if>
                                        <c:if test="${empty buildingEdit.image}">
                                            <img src="/admin/image/default.png" id="viewImage" width="300px" height="300px">
                                        </c:if>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3" for=""></label>
                                    <div class="col-xs-9">
                                        <c:if test="${empty buildingEdit.id}">
                                            <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding" value="1">
                                                Thêm tòa nhà
                                            </button>
                                        </c:if>
                                        <c:if test="${not empty buildingEdit.id}">
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button type="button" class="btn btn-warning" id="btnAddOrUpdateBuilding" value="0">
                                                    Sửa tòa nhà
                                                </button>
                                            </security:authorize>
                                        </c:if>
                                        <a class="btn btn-primary" href="/admin/building-list">
                                            Hủy thao tác
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </form:form>
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->

    <script>

        var imageBase64 = '';
        var imageName = '';

        $('#uploadImage').change(function (event) {
            var reader = new FileReader();
            var file = $(this)[0].files[0];
            reader.onload = function(e){
                imageBase64 = e.target.result;
                imageName = file.name; // ten hinh khong dau, khoang cach. vd: a-b-c
            };
            reader.readAsDataURL(file);
            openImage(this, "viewImage");
        });

        $('#btnAddOrUpdateBuilding').click(function () {
            var data = {};
            var typeCode = [];
            var rentAreas = $('#rentArea').val();
            var districtSelected = $('select[name="district"]').val();
            var formData = $('#form-edit').serializeArray();
            var check = $('#btnAddOrUpdateBuilding').val();
            var url = '/api/buildings';
            var pathArray = window.location.pathname.split('-');
            var buildingId = pathArray[pathArray.length - 1];

            if (check === '0'){
                url = '/api/buildings/' + buildingId;
            }

            $.each(formData, function (i, e) {
                if ('' !== e.value && null != e.value) {
                    data['' + e.name + ''] = e.value;
                }

                if ('' !== imageBase64) {
                    data['imageBase64'] = imageBase64;
                    data['imageName'] = imageName;
                }
            });

            $.each(formData, function (i, it) {
                if (it.name != 'typeCode') data["" + it.name + ""] = it.value;
                else typeCode.push(it.value);
            });
            data['typeCode'] = typeCode;
            data['rentAreas'] = rentAreas;
            data['check'] = check;
            if(typeCode.length == 0) return alert("Loại tòa nhà không được thiếu!!");
            if (!districtSelected) return alert("Quận không được để trống!!");
            else btnAddOrUpdate(data, url);
        });

        function btnAddOrUpdate(data, url) {
            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "text",
                success:(response) =>{
                    alert(response);
                    window.location.replace("/admin/building-list")
                },
                error: function(response){
                    console.log("failed");
                    console.log(response);
                },
            });
        }

        function openImage(input, imageView) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#' +imageView).attr('src', reader.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</body>
</html>
