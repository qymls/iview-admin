<%--
  Created by IntelliJ IDEA.
  User: qymls
  Date: 2020/4/5
  Time: 18:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/admin/public/public_source.jsp" %>
<style>
    .ivu-modal-body {
        max-height: 500px;
        overflow: auto;

    }

    ::-webkit-scrollbar { /*不要滚动条*/
        width: 0;
    }
</style>
<div id="app">
    <Modal v-model="authority" draggable :scrollable="true" width="700">
        <div slot="header">
            <h2>
                <Icon type="md-options"></Icon>
                菜单权限控制
            </h2>
        </div>
        <Row>
            <i-col span="12">
                <div>
                    <Tree :data="authorityTree" transfer show-checkbox ref="tree"
                          @on-check-change="getAuthority"></Tree>
                </div>
            </i-col>
            <Divider type="vertical" style="height: auto;width: 2px"/>
            <i-col span="12">
                <div>
                    <Tree :data="authorityTreeShow"></Tree>
                </div>
            </i-col>

        </Row>

        <div slot="footer">
            <i-button type="primary" @click="saveChang">确认保存</i-button>
        </div>

    </Modal>
</div>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                split1: 0.5,
                authority: true,
                /*权限树*/
                authorityTree: [],
                authorityTreeShow: [],
                menuIds: [],

            }
        },
        mounted() {
            var roleauthority = [];
            $.ajax({/*获取有权限的菜单*/
                type: "POST",
                contentType: "application/x-www-form-urlencoded",
                url: "Admin/Menu/findOne",
                dataType: 'json',
                async: false,/*取消异步加载*/
                success: function (result) {
                    roleauthority = result
                }
            });
            this.getAuthorityDateInfo(this.authorityTree, roleauthority);/*默认勾选已有权限的菜单*/
            var firstCopyArr = $.extend(true, [], roleauthority);//数组的深度复制,不影响原数组
            for (let i = 0; i < firstCopyArr.length; i++) {/*为每个添加title属性并且默认展开*/
                firstCopyArr[i] = $.extend({}, firstCopyArr[i], {title: firstCopyArr[i].name, expand: true});
            }
            var newMenuList = this.getNewChildren(firstCopyArr);
            this.authorityTreeShow = newMenuList

        },
        created() {
            var $page = this;
            $.ajax({
                type: "POST",
                contentType: "application/x-www-form-urlencoded",
                url: "Admin/Menu/findAll",
                dataType: 'json',
                async: false,/*取消异步加载*/
                success: function (result) {
                    $page.getlangData(result)
                    $page.authorityTree = result;

                }
            });
        },
        methods: {
            getAuthorityDateInfo: function (data, roleauthority) {//递归菜单,获取已经有权限的菜单并且打开，选中
                for (let i = 0; i < data.length; i++) {
                    if (data[i].children && data[i].children.length > 0) {/*传过来的都是当前修改菜单的父菜单*/
                        for (let k = 0; k < roleauthority.length; k++) {
                            if (roleauthority[k].id == data[i].id) {/*当最后一层的id等于原来的权限id，就选中*/
                                data[i].expand = true/*将有children的展开*/
                            }
                        }
                        this.getAuthorityDateInfo(data[i].children, roleauthority)
                    } else {
                        for (let j = 0; j < roleauthority.length; j++) {
                            if (roleauthority[j].id == data[i].id) {/*当最后一层的id等于原来的权限id，就选中*/
                                data[i] = $.extend({}, data[i], {checked: true});/*选中原来的权限*/
                            }
                        }
                    }
                }
            },
            saveChang() {/*保存权限修改*/
                console.log(this.menuIds)
            },
            getlangData(data) {//特殊处理一下菜单数据，加入一些其他的属性
                for (let i = 0; i < data.length; i++) {
                    if (data[i].children != undefined && data[i].children.length > 0) {
                        data[i] = $.extend({}, data[i], {title: data[i].name, expand: false});
                        this.getlangData(data[i].children);
                    } else {
                        data[i] = $.extend({}, data[i], {title: data[i].name});
                    }
                }
            },
            getAuthority() {
                let checkedNode = this.$refs.tree.getCheckedAndIndeterminateNodes()/*勾选复选框时触发，获取勾选和半勾选的状态的*/
                var copyArr = $.extend(true, [], checkedNode);//数组的深度复制,不影响原数组
                var newMenuList = this.getNewChildren(copyArr)
                this.authorityTreeShow = newMenuList;
            },
            getNewChildren(copyArr) {/*封装方法，前面也要用的*/
                var $page = this;
                $page.menuIds = []/*每次改变都重新获取值*/
                var firstMenu = [];
                var childrenList = [];
                $.each(copyArr, function (i, object) {
                    $page.menuIds.push(object.id)
                    if (object.parent == 0) {/*获取一级菜单和非一级菜单*/
                        firstMenu.push(object);
                    } else {
                        childrenList.push(object);
                    }
                });
                var newMenuList = [];
                $.each(firstMenu, function (i, object) {
                    object.children = $page.getNewMenu(object.id, childrenList);
                    newMenuList.push(object);
                });
                console.log(newMenuList)/*获得预览菜单数据*/
                return newMenuList;
            },

            getNewMenu(id, childrenList) {/*递归组成新的预览菜单*/
                var newList = [];
                for (let i = 0; i < childrenList.length; i++) {
                    if (id == childrenList[i].parent) {
                        childrenList[i].children = this.getNewMenu(childrenList[i].id, childrenList);
                        newList.push(childrenList[i]);
                    }
                }
                return newList;
            }
        },

    });
</script>
