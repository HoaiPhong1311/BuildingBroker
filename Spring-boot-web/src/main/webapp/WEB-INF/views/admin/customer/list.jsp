<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<c:url var="customerAPI" value="/api/customers"></c:url>

<html>
<head>
    <title>Danh sách khách hàng</title>
</head>

<body>
    <div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value="/admin/home"/>">
                        <%--<spring:message code="label.home"/>--%>
                        Trang chủ
                    </a>
                </li>
                <li class="active">
                    <%--<spring:message code="label.user.list"/>--%>
                    Danh sách khách hàng
                </li>
            </ul>
            <!-- /.breadcrumb -->
        </div>

        <div class="page-content" style="font-family: Arial, Helvetica, sans-serif;">
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
                                <form:form action="/admin/customer-list" modelAttribute="modelSearch" method="GET" id="listForm">
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-4">
                                                    <label>Tên khách hàng</label>
                                                    <form:input path="fullName" class="form-control"></form:input>
                                                </div>
                                                <div class="col-sm-4">
                                                    <label>Di động</label>
                                                    <form:input path="phone" class="form-control"></form:input>
                                                </div>
                                                <div class="col-sm-4">
                                                    <label>Email</label>
                                                    <form:input path="email" class="form-control"></form:input>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-4">
                                                    <label>Tình trạng</label>
                                                    <form:select path="status" class="form-control">
                                                        <form:option value="" label="---Chọn tình trạng---" ></form:option>
                                                        <form:options items="${status}"></form:options>
                                                    </form:select>
                                                </div>
                                                <div class="col-sm-4">
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
                            <a href="/admin/customer-edit">
                                <button title="Thêm khách hàng" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus" viewBox="0 0 16 16">
                                        <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                                        <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
                                    </svg>
                                </button>
                            </a>
                        <security:authorize access="hasRole('MANAGER')">
                            <button title="Xóa khách hàng" class="btn btn-danger" id="btnDeleteCustomers">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M11 7.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5"/>
                                    <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                                </svg>
                            </button>
                        </security:authorize>
                    </div>
                </div>
            </div><!-- /.row -->

            <div class="hr hr-18 dotted hr-double"></div>

            <div class="row">
                <div class="col-xs-12">
                    <display:table name="customerList.listResult" cellspacing="0" cellpadding="0"
                                   requestURI="/admin/customer-list" partialList="true" sort="external"
                                   size="${customerList.totalItems}" defaultsort="2" defaultorder="ascending"
                                   id="tableList" pagesize="${customerList.maxPageItems}"
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
                        <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>
                        <display:column headerClass="text-left" property="customerPhone" title="Di động"/>
                        <display:column headerClass="text-left" property="email" title="Email"/>
                        <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>
                        <display:column headerClass="text-left" property="createdBy" title="Người thêm"/>
                        <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>
                        <display:column headerClass="text-left" property="status" title="Tình trạng"/>
                        <display:column headerClass="col-actions" title="Thao tác">
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-success" title="Giao khách hàng" onclick="assignmentCustomer(${tableList.id})">
                                    <i class="ace-icon glyphicon glyphicon-align-justify"></i>
                                </button>
                            </security:authorize>
                            <a class="btn btn-sm btn-info" title="Sửa khách hàng" href="/admin/customer-edit-${tableList.id}">
                                <i class="ace-icon fa fa-pencil-square-o"></i>
                            </a>
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-danger" title="Xóa khách hàng" onclick="btnDeleteCustomer(${tableList.id})">
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

    <div class="modal fade" id="assignmentCustomerModal" role="dialog">
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
                    <input type="hidden" id="customerId" name="customerId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnAssignCustomer">Giao tòa nhà</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function assignmentCustomer(customerId){
            $('#assignmentCustomerModal').modal();
            $('#customerId').val(customerId);
            loadStaffs(customerId);
        }

        function loadStaffs(customerId){
            $.ajax({
                type: "GET",
                url: "${customerAPI}/" + customerId + "/staffs",
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

        $('#btnAssignCustomer').click(function(e){
            e.preventDefault();
            var data = {};
            data['customerId'] = $('#customerId').val();
            var staffs = $('#staffList').find('tbody input[type = checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['staffs'] = staffs;

            $.ajax({
                type: "PUT",
                url: "${customerAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: (response) =>{
                    alert(response);
                },
                error: function(response){
                    alert("Giao khách hàng không thành công!!");
                },
            });
        });

        $('#btnDeleteCustomers').click(function(e){
            e.preventDefault();
            var data = {};
            var customerIds = $('#tableList').find('tbody tr fieldset input[type = checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['customerIds'] = customerIds;
            deleteCustomer(data);
        });

        function btnDeleteCustomer(customerId){
            var data = {};
            data['customerIds'] = customerId;
            deleteCustomer(data);
        }

        function deleteCustomer(data){
            $.ajax({
                type: "DELETE",
                url: "${customerAPI}/" + data['customerIds'],
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "text",
                success:(response) =>{
                    alert(response);
                    window.location.replace("/admin/customer-list")
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
            $('#listForm').attr('action', '/admin/customer-list'); // Đặt action cho form
            $('#listForm').submit(); // Submit form
        });

    </script>

</body>
</html>
