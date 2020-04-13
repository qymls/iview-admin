<%--
  Created by IntelliJ IDEA.
  User: qymls
  Date: 2020/3/27
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1"><!--适配所有设备，主键1-1-->
    <link rel="stylesheet" type="text/css" href="iview/iview.css">
    <script src="iview/vue.js"></script>
    <script src="iview/iview.min.js"></script>
    <script src="iview/jquery-3.4.1.min.js"></script>
    <script src="iview/vue-i18n.min.js"></script>
</head>
<body>
<style type="text/css">
    body, html {
        background: #f5f7f9;
    }

    .layout {

    }

    .layout-logo {

        border-radius: 3px;
        float: left;

    }

    .layout-logo img {
        height: 44px;
        width: auto;
    }

    .layout-content {
        height: 606px;
        position: absolute;
        right: 0;
        left: 0;
        top: 0;
        bottom: 90px;
        margin: 15px;
        overflow: hidden;
        border-radius: 4px;
    }

    .layout-content-main {
        background-color: #F0F0F0;
    }

    .layout-copy {
        text-align: center;
        padding: 5px 0 10px;
        color: #9ea7b4;
        position: absolute;
        bottom: 0;
        right: 0;
        left: 0;
        width: 100%;

    }

    .layout-top {
        width: 100%;
        height: 82px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .main-header-con {
        top: 0;
        box-sizing: border-box;
        position: fixed;
        display: block;
        width: 100%;
        z-index: 20;
        /*box-shadow: 0 2px 1px 1px rgba(100, 100, 100, 0.1);*/
        transition: padding .3s;
    }

    .main-header {
        background: #fff;
        box-shadow: 0 2px 1px 1px rgba(100, 100, 100, 0.1);
        z-index: 11;
        display: flex;
        align-items: center;
    }

    .navicon-con {
        margin: 15px;
        display: inline-block;
    }

    .header-middle-con {
        display: inline-block;
        vertical-align: top;
        margin-left: 15px
    }

    .header-avator-con {
        float: right;
        height: auto;
        padding-right: 20px;
        line-height: 64px;
    }

    .full-screen-btn-con, .lock-screen-btn-con, .message-con {
        display: inline-block;
        width: 42px;
        padding: 18px 0;
        text-align: center;
        cursor: pointer;
        padding-left: 35px;
    }

    .user-dropdown-menu-con {
        position: absolute;
        right: 0;
        top: 14px;
        width: 150px;
        height: 100%;
    }

    .left-menu { /*菜单栏*/
        min-width: 256px;
        max-width: 256px;
        flex: 0 0 256px;
        overflow: hidden;
        top: 0;
        position: fixed;
        background: #001529;;
        height: 100%;
        left: 0;
        overflow-x: hidden;
        overflow-y: auto;
    }

    .right-content {
        background: #e3e8ee;
        left: 256px;
        position: fixed;
        top: 0;
    }

    .ivu-menu-dark { /*主题颜色*/
        background: #001529;
    }

    .ivu-menu-item { /*子菜单颜色*/
        /*background: #000000;*/
    }

    .ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened .ivu-menu-submenu-title { /*菜单打开时的颜色*/
        background: #001529;
    }

    .title-admin {
        margin-left: 17px;
    }

    h2 {
        /* color: aliceblue;*/
    }

    .index {
        display: flex;
    }


    .ivu-tabs-nav {
        margin-top: 2px;
    }

    .ivu-tabs-nav-next, .ivu-tabs-nav-prev { /*调整tabs的样式*/
        display: flex;
        align-items: center;
        justify-content: center;
        position: absolute;
        top: 0px;
        height: 100%;
        width: 28px;
        background: #fff;
        padding-top: 3px;
        z-index: 10;
    }

    .ivu-tabs.ivu-tabs-card > .ivu-tabs-bar .ivu-tabs-nav-wrap {

        height: 38px;
    }


    .ivu-tabs.ivu-tabs-card > .ivu-tabs-bar .ivu-tabs-nav-container {
        height: 38px;
    }

    .ivu-tabs-nav-next i, .ivu-tabs-nav-prev i {
        font-size: 18px;
    }

    .ivu-tabs-nav-next {
        right: 0;
        border-right: 1px solid #F0F0F0;
    }

    .ivu-tabs-bar {
        border-bottom: 2px solid #dcdee2;
        margin-bottom: 1px;
        border-top: 1px solid #dcdee2;
        margin-top: 1px;
        padding-bottom: 2px;
    }

    .ivu-tabs.ivu-tabs-card > .ivu-tabs-bar .ivu-tabs-tab {
        border-bottom: 1px solid #dcdee2;
        border-radius: 3px 3px 3px 3px;
    }

    .ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened { /*菜单展开样式*/

        background: #000000;
    }

    .ivu-menu-dark.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu), .ivu-menu-dark.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu):hover, .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title-active:not(.ivu-menu-submenu), .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title-active:not(.ivu-menu-submenu):hover {
        background: #0a90ef;
    }

    .ivu-menu-dark.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu), .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title-active:not(.ivu-menu-submenu) {
        color: #fff;;
    }


</style>
<style scoped>
    .layout {
        /*  border: 1px solid #d7dde4;
          background: #f5f7f9;
          position: relative;
          border-radius: 4px;
          overflow: hidden;*/
    }

    .layout-header-bar {
        background: #fff;
        box-shadow: 0 1px 1px rgba(0, 0, 0, .1);

    }

    .layout-logo-left {
        width: 90%;
        height: 30px;
        background: #5b6270;
        border-radius: 3px;
        margin: 15px auto;
    }

    .menu-icon {
        transition: all .3s;
    }

    .rotate-icon {
        transform: rotate(-90deg);
    }

    .menu-item span {
        display: inline-block;
        overflow: hidden;
        width: 69px;
        text-overflow: ellipsis;
        white-space: nowrap;
        vertical-align: bottom;
        transition: width .2s ease .2s;
    }


    .collapsed-menu span {
        width: 0px;
        transition: width .2s ease;
    }

    .collapsed-menu i {
        transform: translateX(5px);
        transition: font-size .2s ease .2s, transform .2s ease .2s;
        vertical-align: middle;
        font-size: 22px;
    }

    .menu-side {
        background-color: #001529;
        overflow: hidden;
    }

    .ivu-layout-sider-children {
        overflow-y: scroll;
        overflow-x: hidden;
        margin-right: -15px;
    }

    .ivu-tabs-nav-scroll {
        position: absolute;
        left: 36px;
        right: 30px;
        top: 1.5px;
    }

    .close-con {
        width: 32px;
        background: #fff;
        z-index: 10;
        height: 38px;
        display: flex;
        align-items: center;
    }

    .ivu-tabs-nav-right {
        margin-left: 0;
    }

    .left_menu_ss {
        text-align: center;
        padding-top: 10px;
    }

    .list-object {
        display: grid;
    }

    .span_icon {
        padding-left: 5px;
        padding-right: 5px;
    }

    .side-trigger-a-my {
        padding: 6px;
        width: 40px;
        height: 40px;
        display: inline-block;
        text-align: center;
        color: #5c6b77;
        margin-top: 15px;
    }

    .icon_refresh { /*刷新按钮*/
        display: inline-block;
        cursor: pointer;
        color: #5c6b77;
    }

    #app {
        height: 100%;
        width: 100%;
        overflow: hidden;
    }

    .toot_style {
        width: 100%;
    }

    .transfer_style {
        overflow: visible;
        /*非常重要的属性，关于dropdown的，移动到下一级就消失的问题*/
    }

    body {
        overflow: hidden; /*解决dropdown产生滚动条的bug*/
    }

    .ivu-tabs-content { /*设置和iframe的高度相同，不然的话iframe切换会闪动，一闪一闪的*/
        height: 100%;
    }


</style>
<div id="app">
    <template>
        <Layout style="height: 100%">
            <Sider ref="side1" hide-trigger collapsible :collapsed-width="65" v-model="isCollapsed" :width="256"
                   class="menu-side">
                <template v-if="!isCollapsed">
                    <div>
                        <i-menu :theme="theme.right_menu_style" ref="refresh" :active-name="activeName" width="auto"
                                accordion
                                :open-names="openMenuName"
                                @on-select="menuSelect">
                            <div class="layout-top">
                                <div class="layout-logo">
                                    <img src="https://i.loli.net/2017/08/21/599a521472424.jpg">
                                </div>
                                <div class="title-admin"><h2 :style="theme.right_menu_h2">后端管理系统</h2></div>
                            </div>
                            <Submenu v-for="item in menuData" v-if="item.children&&item.children.length!==0"
                                     :name="item.name">
                                <template slot="title">
                                    <Icon v-bind:type="item.icon"></Icon>
                                    <span class="span_icon">{{$t(item.label)}}</span>
                                </template>
                                <left-Nav-Children :parent-item="item.children">
                                </left-Nav-Children>
                            </Submenu>
                            <menu-item v-else-if="item.name!='首页'" :name="item.name">
                                <Icon v-bind:type="item.icon"></Icon>
                                <span class="span_icon">{{$t(item.label)}}</span>
                            </menu-item>
                        </i-menu>
                    </div>
                </template>
                <!--收缩后样式菜单-->
                <template v-else>
                    <div class="layout-top">
                        <div class="layout-logo">
                            <img src="https://i.loli.net/2017/08/21/599a521472424.jpg">
                        </div>
                    </div>
                    <div class="list-object">
                        <Dropdown placement="right" class="left_menu_ss" v-for="item in menuData"
                                  v-if="item.children&&item.children.length!==0" @on-click="drop_click" transfer
                                  transfer-class-name="transfer_style">
                            <a type="text" class="drop-menu-a">
                                <Icon v-bind:type="item.icon" size="20" style="color: rgb(255, 255, 255)"></Icon>
                            </a>
                            <Dropdown-Menu slot="list" style="text-align: left">
                                <Dropdown v-for="item in item.children"
                                          v-if="item.children&&item.children.length!==0" placement="right-start">
                                    <Dropdown-item name="stop_click"><!--禁用父菜单，不能被点击-->
                                        <Icon :type="item.icon"></Icon>
                                        <span>{{$t(item.name)}}</span>
                                        <Icon type="ios-arrow-forward"></Icon>
                                    </Dropdown-item>
                                    <!--递归-->
                                    <Dropdown-Menu slot="list">
                                        <left-Nav-Children-Shrink-Menu :parent-item-menu='item.children'>

                                        </left-Nav-Children-Shrink-Menu>
                                    </Dropdown-Menu>
                                </Dropdown>
                                <Dropdown-Item v-else :name="item.name">
                                    <Icon :type="item.icon"></Icon>
                                    <span>{{$t(item.name)}}</span>
                                </Dropdown-Item>
                            </Dropdown-Menu>
                        </Dropdown>

                        <Tooltip v-else-if="item.name!='首页'" :content="$t(item.name)" class="left_menu_ss toot_style"
                                 placement="right" transfer>
                            <a type="text" class="drop-menu-a" @click="tooltip_click(item.name)">
                                <Icon :type="item.icon" style="font-size: 23px;color: rgb(255, 255, 255)"/>
                            </a>
                        </Tooltip>
                    </div>
                </template>

            </Sider>
            <Layout style="overflow: hidden;">
                <Header style="padding: 0 20px;height: 64px;line-height: 64px;" class="layout-header-bar">
                    <a type="text" class="side-trigger-a-my" href="javascript:void(0)" @click="collapsedSider">
                        <Icon type="md-menu" :class="rotateIcon"
                              style="font-size: 26px"/>
                    </a>
                    <a class="icon_refresh" href="javascript:void(0)" @click="globalRefresh">
                        <Icon type="ios-refresh" style="font-size: 26px"/>
                    </a>

                    <div class="header-middle-con">
                        <Breadcrumb>
                            <Breadcrumb-Item v-for="(item,index) in breadRum" :to="item.url">
                                <Icon :type="item.icon"></Icon>
                                {{$t(item.name)}}
                            </Breadcrumb-Item>
                        </Breadcrumb>
                    </div>

                    <div class="header-avator-con">
                        <div class="full-screen-btn-con" @click="handleFullScreen">
                            <Tooltip :content="fullscreen ? '取消全屏':'全屏'" transfer>
                                <Icon type="md-expand" style="font-size: 23px;"/>
                            </Tooltip>
                        </div>
                        <Dropdown style="margin-left: 36px" transfer @on-click="changeLang">
                            <a href="javascript:void(0)">
                                语言
                                <Icon type="ios-arrow-down"></Icon>
                            </a>
                            <Dropdown-Menu slot="list">
                                <Dropdown-Item name="zh_CN">中文简体</Dropdown-Item>
                                <Dropdown-Item name="en_US">English</Dropdown-Item>
                            </Dropdown-Menu>
                        </Dropdown>

                        <Dropdown style="margin-left: 18px;" transfer @on-click="personClick">
                            <a href="javascript:void(0)">
                                iview-admin
                                <Icon type="ios-arrow-down"></Icon>
                            </a>
                            <Dropdown-Menu slot="list">
                                <Dropdown-Item name="个人中心">
                                    <Icon type="ios-settings-outline"></Icon>
                                    个人设置
                                </Dropdown-Item>
                                <Dropdown-Item divided name="refresh">
                                    <Icon type="ios-refresh"></Icon>
                                    全局刷新
                                </Dropdown-Item>
                                <Dropdown-Item divided name="logout">
                                    <Icon type="ios-log-out"></Icon>
                                    退出登录
                                </Dropdown-Item>
                            </Dropdown-Menu>
                        </Dropdown>
                        <Avatar src="https://i.loli.net/2017/08/21/599a521472424.jpg"/>


                    </div>
                </Header>

                <i-Content>
                    <div class="layout-content-main">

                        <Tabs type="card" size="small" @on-tab-remove="removeTab" :animated="false"
                              v-model="activeTab" @on-click="tabclick" :before-remove='beforeRemove'>
                            <template v-for="(item,index) in mainTabs">
                                <tab-pane v-bind:icon="item.icon" :label="$t(item.label)" closable :name="item.name"
                                          v-if="item.show" class="demo-tabs-style2">
                                    <iframe frameborder="0" width="100%" height="100%" marginheight="0"
                                            style="background-color: white"
                                            marginwidth="0"
                                            :src="item.url">

                                    </iframe>

                                </tab-pane>
                            </template>
                            <div class="close-con" slot="extra">
                                <Dropdown @on-click="closeTabs" transfer>
                                    <i-button type="text" size="small">
                                        <Icon type="ios-close-circle-outline" style="font-size: 18px"></Icon>
                                    </i-button>

                                    <Dropdown-Menu slot="list">
                                        <Dropdown-Item name="close-other">关闭其他</Dropdown-Item>
                                        <Dropdown-Item name="close-all">关闭所有</Dropdown-Item>
                                    </Dropdown-Menu>
                                </Dropdown>
                            </div>
                        </Tabs>

                    </div>

                </i-Content>
            </Layout>
        </Layout>
    </template>

</div>
<script type="module" src="admin/admin.js"></script>
</body>
</html>