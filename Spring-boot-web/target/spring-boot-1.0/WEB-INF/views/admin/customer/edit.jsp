<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerEditURL" value="/admin/customer-edit"></c:url>
<html>
<head>
    <title>Thông tin khách hàng</title>
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
                        Thông tin khách hàng
                    </li>
                </ul>
                <!-- /.breadcrumb -->
            </div>

            <div class="page-content" style="font-family: Arial, Helvetica, sans-serif;">
                <div class="page-header">
                    <h1>Thông tin khách hàng
                    </h1>
                </div><!-- /.page-header -->

                <div class="row" style="font-family: Arial, Helvetica, sans-serif;">
                    <form:form modelAttribute="customerEdit" action="${customerEditURL}" method="get" id="form-edit">
                        <div class="col-xs-12">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-xs-3">Tên khách hàng</label>
                                    <div class="col-xs-9">
                                        <form:input path="fullName" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Số điện thoại</label>
                                    <div class="col-xs-9">
                                        <form:input path="customerPhone" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Email</label>
                                    <div class="col-xs-9">
                                        <form:input path="email" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Tên công ty</label>
                                    <div class="col-xs-9">
                                        <form:input path="companyName" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Nhu cầu</label>
                                    <div class="col-xs-9">
                                        <form:input path="demand" class="form-control"></form:input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" id="status">Tình trạng</label>
                                    <div class="col-xs-4">
                                        <form:select path="status" class="form-control">
                                            <form:options items="${status}"></form:options>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3" ></label>
                                    <div class="col-xs-9">
                                        <c:if test="${empty customerEdit.id}">
                                            <button type="button" class="btn btn-primary" id="btnAddOrUpdateCustomer" value="1">
                                                Thêm khách hàng
                                            </button>
                                        </c:if>
                                        <c:if test="${not empty customerEdit.id}">
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button type="button" class="btn btn-warning" id="btnAddOrUpdateCustomer" value="0">
                                                    Sửa khách hàng
                                                </button>
                                            </security:authorize>
                                        </c:if>
                                        <a class="btn btn-primary" href="/admin/customer-list">
                                            Hủy thao tác
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </form:form>
                </div>

                <div class="hr hr-18 dotted hr-double"></div>

                <c:forEach var="item" items="${transactionType}">
                    <div class="col-xs-12">
                        <div class="col-sm-12">
                            <h3 class="header smaller lighter blue">${item.value}</h3>
                            <button class="btn btn-lg btn-primary" onclick="transactionType('${item.key}', ${customerEdit.id})">
                                <i class="orange ace-icon fa fa-location-arrow bigger-130"></i>Add
                            </button>
                        </div>
                        <c:if test="${item.key == 'CSKH'}">
                            <div class="col-xs-12">
                                <table id="transactionList" class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>Ngày tạo</th>
                                        <th>Người tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Người sửa</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <c:forEach var="x" items="${transactionList}">
                                        <tr>
                                            <td>${x.createdDate}</td>
                                            <td>${x.createdBy}.</td>
                                            <td>${x.modifiedDate}.</td>
                                            <td>${x.modifiedBy}</td>
                                            <td>${x.transactionDetail}</td>
                                            <td>
                                                <div class="hidden-sm hidden-xs btn-group">
                                                    <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Sửa thông tin giao dịch"
                                                            onclick="UpdateTransaction(${x.id})">
                                                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </c:if>

                        <c:if test="${item.key == 'DDX'}">
                            <div class="col-xs-12">
                                <table id="transactionList2" class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>Ngày tạo</th>
                                        <th>Người tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Người sửa</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <c:forEach var="y" items="${transactionList2}">
                                        <tr>
                                            <td>${y.createdDate}</td>
                                            <td>${y.createdBy}.</td>
                                            <td>${y.modifiedDate}.</td>
                                            <td>${y.modifiedBy}</td>
                                            <td>${y.transactionDetail}</td>
                                            <td>
                                                <div class="hidden-sm hidden-xs btn-group">
                                                    <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Sửa thông tin giao dịch"
                                                            onclick="UpdateTransaction(${y.id})">
                                                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>

                                </table>

                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="modal fade" id="transactionTypeModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Nhập giao dịch</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group has-success">
                        <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">Chi tiết giao dịch</label>
                        <div class="col-xs-12 col-sm-9">
                            <span class="block input-icon input-icon-right">
                                <input type="text" id="transactionDetail" class="width-100">
                            </span>
                        </div>
                    </div>
                    <input type="hidden" id="customerId" name="customerId" value="">
                    <input type="hidden" id="code" name="code" value="">
                    <input type="hidden" id="id" name="id" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnAddOrUpdateTransaction">Thêm giao dịch</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function transactionType(code, customerId){
            $('#transactionDetail').val('');
            $('#id').val('');
            $('#transactionTypeModal').modal();
            $('#customerId').val(customerId);
            $('#code').val(code);
        }

        function UpdateTransaction(idTransaction){
            $.ajax({
                type: "GET",
                url: `/api/customers/transactions/` + idTransaction,
                success: function(response) {
                    var transactionData = response.data;
                    $('#transactionDetail').val(transactionData.transactionDetail);
                    $('#transactionTypeModal').modal();
                    $('#id').val(idTransaction);
                },
                error: function(response) {
                    console.log("failed to fetch transaction data");
                    console.log(response);
                }
            });
        }

        $('#btnAddOrUpdateTransaction').click(function (e) {
           e.preventDefault();
           var data = {};
           data['id'] = $('#id').val();
           data['customerId'] = $('#customerId').val();
           data['code'] = $('#code').val();
           data['transactionDetail'] = $('#transactionDetail').val();
           addTransaction(data);
        });

        function addTransaction(data){
            $.ajax({
                type: "POST",
                url: '/api/customers/transaction',
                data: JSON.stringify(data),
                contentType: "application/json",
                success:(response) =>{
                    alert(response);
                    window.location.reload();
                },
                error: function (){
                    alert("Add or Update Failed");
                },
            });
        }

        $('#btnAddOrUpdateCustomer').click(function () {
            var data = {};
            var name = $('#fullName').val();
            var phone = $('#customerPhone').val();
            var formData = $('#form-edit').serializeArray();
            var check = $('#btnAddOrUpdateCustomer').val();
            var url = '/api/customers';
            var pathArray = window.location.pathname.split('-');
            var customerId = pathArray[pathArray.length - 1];

            if (check === '0'){
                url = '/api/customers/' + customerId;
            }

            $.each(formData, function (i, it) {
                data["" + it.name + ""] = it.value;
            });

            data['check'] = check;
            if(name === '') return alert("Tên khách hàng không được thiếu!!!");
            if(phone === '') return alert("Số điện thoại không được thiếu!!!");
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
                    window.location.replace("/admin/customer-list");
                },
                error: function(response){
                    console.log("failed");
                    console.log(response);
                },
            });
        }
    </script>

</body>
</html>
