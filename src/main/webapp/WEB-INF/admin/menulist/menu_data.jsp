<%--
  Created by IntelliJ IDEA.
  User: qymls
  Date: 2020/3/28
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/admin/public/public_source.jsp" %>
<div id="app">

    <Card>
        <p slot="title">
            <Icon type="ios-list-box-outline" size="20"></Icon>
            {{title}}
        </p>

        <Row>
            <i-col span="5">
                <i-button type="primary" icon="md-add" @click="newMenu">菜单管理</i-button>
            </i-col>
            <i-col span="19">
                <i-Form ref="formInline" :model="formInline" inline>
                    <Form-Item prop="name">
                        <i-Input type="text" v-model="formInline.name" placeholder="请输入查找的菜单名称">
                            <Icon type="ios-person-outline" slot="prepend"></Icon>
                        </i-Input>
                    </Form-Item>
                    <Form-Item prop="time">
                        <Date-Picker type="datetimerange" v-model="formInline.time" format="yyyy-MM-dd HH:mm"
                                     placeholder="请选择时间" style="width: 300px"></Date-Picker>
                    </Form-Item>

                    <Form-Item>
                        <i-Button type="primary" @click="handleSubmit('formInline')">查找</i-Button>
                    </Form-Item>
                </i-Form>
            </i-col>

        </Row>

        <Row justify="center" align="middle">
            <div style="margin-top:20px">
                <i-Table row-key="name" :columns="columns" :data="menuData" border></i-Table>
            </div>
            <div style="margin: 10px;overflow: hidden">
                <div style="float: right;">
                    <Page :total="total" show-total :page-size="pageSize" :page-size-opts="[5,10,20]" :current="page"
                          show-sizer transfer show-elevator
                          @on-change="changePage" @on-page-size-change="sizeChange"
                          style="line-height: unset"></Page>
                </div>
            </div>
        </Row>


    </Card>


</div>
<script>
    new Vue({
        el: "#app",
        data: function () {
            return {
                title: "菜单详情",
                rows: [],
                formInline: {
                    name: '',
                    time: ''
                },
                columns: [
                    {
                        title: '菜单名称',
                        key: 'name',
                        tree: true
                    },
                    {
                        title: '菜单图标',
                        key: 'icon',
                    },
                    {
                        title: '菜单地址',
                        key: 'url',
                    }
                ],
                menuData: [],
                total: 0,
                page: 1,/*当前页默认为1*/
                pageSize: 5,/* 默认5条*/
            }
        },
        created() {
            this.getFirstMenuData(this.page, this.pageSize);
        },
        methods: {
            handleSubmit() {
                this.getFirstMenuData(this.page, this.pageSize)
            },
            changePage(page) {
                this.page = page/*改变就设置值*/
                this.getFirstMenuData(page, this.pageSize);
            },
            sizeChange(pageSize) {/*改变就设置值*/
                this.pageSize = pageSize
                this.getFirstMenuData(this.page, pageSize);/*改变后page默认会变成1*/
            },

            getFirstMenuData(page, pageSize) {
                var $page = this;
                $.ajax({
                    type: "POST",
                    contentType: "application/x-www-form-urlencoded",
                    url: "Admin/Menu/findAllMenu",
                    data: {
                        "name": this.formInline.name,
                        "time": this.formInline.time,
                        "page": page,
                        "pageSize": pageSize
                    },
                    dataType: 'json',
                    traditional:true,//防止深度序列化
                    async: false,/*取消异步加载*/
                    success: function (result) {
                        console.log(result)
                        $page.menuData = result.list;
                        $page.total = result.totalRows;
                        $page.page = result.page/*处理一个小bug*/
                    }
                });
            },
            newMenu: function () {
                window.location.href = 'Admin/Menu/forwardMenuEdit';/*跳转edit.jsp*/
            },
            deleteMenu: function () {

            },
        },

    });
</script>
