<%--要引用jstl的jar包--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%><!--支持EL表达式，不设的话，EL表达式不会解析-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>图书列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/bootstrap-theme.css">
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.js"></script>
</head>
<body>
<!-- 图书修改的模态框 -->
<div class="modal fade" id="bookUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">图书修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">bookName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="bookName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">price</label>
                        <div class="col-sm-10">
                            <input type="text" name="price" class="form-control" id="price_update_input" placeholder="书的价格">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">author</label>
                        <div class="col-sm-10">
                            <input type="text" name="author" class="form-control" id="author_update_input" placeholder="作者">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sales</label>
                        <div class="col-sm-10">
                            <input type="text" name="sales" class="form-control" id="sales_update_input" placeholder="销量">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">booKFactory</label>
                        <div class="col-sm-4">
                            <!-- 部门提交书厂id即可 -->
                            <select class="form-control" name="fid">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="book_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<%--<!-- 员工添加的模态框 -->--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">图书添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">bookName</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="bookName_add_input" placeholder="bookName">
                            <span class="help-block"></span>
                        </div>
                        <label class="col-sm-2 control-label">price</label>
                        <div class="col-sm-10">
                            <input type="text" name="price" class="form-control" id="price_add_input" placeholder="price">
                            <span class="help-block"></span>
                        </div>
                        <label class="col-sm-2 control-label">author</label>
                        <div class="col-sm-10">
                            <input type="text" name="author" class="form-control" id="author_add_input" placeholder="author">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">factoryName</label>
                        <div class="col-sm-4">
                            <!-- fid与book中的属性对应 -->
                            <select class="form-control" name="fid">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="book_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>id</th>
                    <th>bookName</th>
                    <th>price</th>
                    <th>author</th>
                    <th>sales</th>
                    <th>factory_name</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>
<script type="text/javascript">

    var totalRecord,currentPage;
    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    function to_page(pn){
        $("#check_all").prop("checked",false);
        $.ajax({
            url:"${APP_PATH}/books",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result){
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.map.pageInfo.list;
        $.each(emps,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var bookId = $("<td></td>").append(item.id);
            var bookName = $("<td></td>").append(item.name);
            var price = $("<td></td>").append(item.price);
            var author = $("<td></td>").append(item.author);
            var sales = $("<td></td>").append(item.sales);
            var fname = $("<td></td>").append(item.factory.fname);
            /**
             <button class="">
             <span class="" aria-hidden="true"></span>
             编辑
             </button>
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.id);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id",item.id);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(bookId)
                .append(bookName)
                .append(price)
                .append(author)
                .append(sales)
                .append(fname)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.map.pageInfo.pageNum+"页,总"+
            result.map.pageInfo.pages+"页,总"+
            result.map.pageInfo.total+"条记录");
        totalRecord = result.map.pageInfo.total;
        currentPage = result.map.pageInfo.pageNum;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result){
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.map.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.map.pageInfo.pageNum -1);
            });
        }



        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.map.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.map.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.map.pageInfo.pages);
            });
        }



        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.map.pageInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.map.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框。
    $("#emp_add_modal_btn").click(function(){
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModal form");
        //s$("")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getFactory("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //查出所有的书厂信息并显示在下拉列表中
    function getFactory(ele){
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/factory",
            type:"GET",
            success:function(result){
                //{"code":100,"msg":"处理成功！",
                //"extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                //console.log(result);
                //显示部门信息在下拉列表中
                //$("#empAddModal select").append("")
                $.each(result.map.bfs,function(){
                    //显示的是书厂名,发送的是fid
                    var optionEle = $("<option></option>").append(this.fname).attr("value",this.id);
                    optionEle.appendTo(ele);
                });
            }
        });

    }

    //校验表单数据
    function validate_add_form(){
        //1、拿到要校验的数据，使用正则表达式
        var bookName = $("#bookName_add_input").val();
        var price = $("#price_add_input").val();
        var author = $("#author_add_input").val();
        //！！！！！！！！认真认真再认真,是双等号！！！！！！！
        if (bookName=="" || price==""||author==""){
            return false;
        }
        var regName = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
        if(!regName.test(bookName)){
            alert("书名可以是中文或者英文和数字的组合(不能有特殊符号)");
            show_validate_msg("#bookName_add_input", "error", "书名不能包含特殊符号");
            return false;
        }else{
            show_validate_msg("#bookName_add_input", "success", "书名合法");
        };
        regName=/(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
        if(!regName.test(price)){
            show_validate_msg("#price_add_input", "error", "价格不合法");
            return false;
        }else{
            show_validate_msg("#price_add_input", "success", "");
        };
        regName=/^([\u4e00-\u9fa5a-zA-Z]{1,20})$/;
        if(!regName.test(author)){

            show_validate_msg("#author_add_input", "error", "作者名不合法");
            return false;
        }else{
            show_validate_msg("#author_add_input", "success", "");
        };
        return true;


    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验书名是否可用
    $("#bookName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var bookName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkBook",
            data:"bookName="+bookName,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#bookName_add_input","success","书名合法");
                    $("#book_save_btn").attr("ajax-va","success");
                }else if(result.code==200){
                    show_validate_msg("#bookName_add_input","error","书名已存在");
                    $("#book_save_btn").attr("ajax-va","error");
                }else {
                    show_validate_msg("#bookName_add_input","error","书名不合法");
                    $("#book_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //检验价格是否合法
    $("#price_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var price = this.value;
        $.ajax({
            url:"${APP_PATH}/checkPrice",
            data:"price="+price,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#price_add_input","success","");
                    $("#book_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#price_add_input","error","价格不合法(必须为整数或小数)");
                    $("#book_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //检验作者名是否合法
    $("#author_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var author = this.value;
        $.ajax({
            url:"${APP_PATH}/checkAuthor",
            data:"author="+author,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#author_add_input","success","");
                    $("#book_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#author_add_input","error","作者名不合法(不能有特殊字符和数字)");
                    $("#book_save_btn").attr("ajax-va","error");
                }
            }
        });
    });


    //点击保存，保存员工。
    $("#book_save_btn").click(function(){
        //1、模态框中填写的表单数据提交给服务器进行保存
        //1、先对要提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        };
        //1、判断之前的ajax用户名校验是否成功。如果成功。
        if($(this).attr("ajax-va")=="error"){
            return false;
        }

        //2、发送ajax请求保存图书
        $.ajax({
            url:"${APP_PATH}/books",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function(result){
                //alert(result.msg);
                if(result.code == 100){
                    //员工保存成功；
                    //1、关闭模态框
                    $("#empAddModal").modal('hide');

                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                }
            }
        });
    });

    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    $(document).on("click",".edit_btn",function(){
        //alert("edit");


        //1、查出书厂信息，并显示书厂部门列表
        getFactory("#bookUpdateModal select");
        //2、查出员工信息，显示员工信息
        getBook($(this).attr("edit-id"));

        //3、把员工的id传递给模态框的更新按钮
        $("#book_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#bookUpdateModal").modal({
            backdrop:"static"
        });
    });

    function getBook(id){
        $.ajax({
            url:"${APP_PATH}/book/"+id,
            type:"GET",
            success:function(result){
                //console.log(result);
                var book = result.map.book;
                $("#bookName_update_static").text(book.name);
                $("#price_update_input").val(book.price);
                $("#author_update_input").val(book.author);
                $("#sales_update_input").val(book.sales);
                $("#bookUpdateModal select").val([book.factory.id]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#book_update_btn").click(function(){
        //验证价格,作者,销量是否合法
        //1、校验信息
        var price = $("#price_update_input").val();
        var regPrice = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
        var regAuthor = /^([\u4e00-\u9fa5a-zA-Z]{1,20})$/;
        var author=$("#author_update_input").val();
        var sales=$("#sales_update_input").val();
        var regSales = /^[1-9]\d*$/;


        if(!regPrice.test(price)){
            show_validate_msg("#price_update_input", "error", "价格格式不正确(必须为整数或小数)");
            return false;
        }else{
            show_validate_msg("#price_update_input", "success", "");
        }
        if(!regAuthor.test(author)){
            show_validate_msg("#author_update_input", "error", "作者名不合法(不能有特殊字符或空格)");
            return false;
        }else{
            show_validate_msg("#author_update_input", "success", "");
        }
        if(!regSales.test(sales)){
            show_validate_msg("#sales_update_input", "error", "销量必须为整数");
            return false;
        }else{
            show_validate_msg("#sales_update_input", "success", "");
        }

        //2、发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/book/"+$(this).attr("edit-id"),
            type:"post",
            data:$("#bookUpdateModal form").serialize()+"&_method=PUT",
            success:function(result){

                //1、关闭对话框
                $("#bookUpdateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click",".delete_btn",function(){
        //1、弹出是否确认删除对话框
        var bookName = $(this).parents("tr").find("td:eq(2)").text();
        var bookId = $(this).attr("del-id");
        if(confirm("确认删除【"+bookName+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/book/"+bookId,
                type:"post",
                data:"_method=DELETE",
                success:function(result){
                    alert("删除成功");
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function(){
        //判断当前选中几个元素
        var len = $(".check_item:checked").length;
        if (len==0){
            alert("你还没选择要删除的元素");
            return;
        }
        var bookNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            //this
            bookNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装图书id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的,
        bookNames = bookNames.substring(0, bookNames.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if(confirm("确认删除【"+bookNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/book/"+del_idstr,
                type:"post",
                data:"_method=DELETE",
                success:function(result){
                    alert("删除多个图书成功");
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>