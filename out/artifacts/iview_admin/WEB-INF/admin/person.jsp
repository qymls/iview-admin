<%--
  Created by IntelliJ IDEA.
  User: qymls
  Date: 2020/3/28
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/admin/public/public_source.jsp" %>
<style>
    .ivu-tabs-bar {
        height: fit-content;
        display: none;
    }

</style>
<div id="app">
    <div>
        <Row style="margin-top: 20px;">
            <i-col :xs="{span: 0}" :lg="{span: 6}" :xl="{span: 6}" :sm="{span: 0}" :md="{span: 0}"
                   style="padding-left: 12px; padding-right: 12px;">
                <Card>
                    <p slot="title">
                        <Icon type="md-options" size="20"></Icon>
                        {{title}}
                    </p>
                    <Cell-Group @on-click="settingChang">
                        <Cell v-for="item in baseInfo" :title="item.name" :label="item.deslabel"
                              :name="item.name"></Cell>
                    </Cell-Group>

                </Card>
            </i-col>
            <i-col :xs="{span: 24}" :lg="{span: 18}" :xl="{span: 18}" :sm="{span: 24}" :md="{span: 24}"
                   style="padding-left: 12px; padding-right: 12px;">
                <Card>

                    <h2>{{activeTab}}</h2>


                    <Tabs :animated="false" v-model="activeTab">
                        <Tab-Pane label="基本设置" name="基本设置">
                            <div style="padding-top: 20px">
                                <i-Form ref="formInline" :model="formInline" :rules="ruleInline">
                                    <Form-Item prop="user">
                                        <i-Input type="text" v-model="formInline.user" placeholder="Username">
                                            <Icon type="ios-person-outline" slot="prepend"></Icon>
                                        </i-Input>
                                    </Form-Item>
                                    <Form-Item prop="password">
                                        <i-Input type="password" v-model="formInline.password" placeholder="Password">
                                            <Icon type="ios-lock-outline" slot="prepend"></Icon>
                                        </i-Input>
                                    </Form-Item>
                                    <Form-Item>
                                        <i-Button type="primary" @click="handleSubmit('formInline')">Signin</i-Button>
                                    </Form-Item>
                                </i-Form>
                            </div>
                        </Tab-Pane>
                        <Tab-Pane label="安全设置" name="安全设置">安全设置</Tab-Pane>
                        <Tab-Pane label="账号绑定" name="账号绑定">账号绑定</Tab-Pane>
                    </Tabs>

                </Card>
            </i-col>

        </Row>
    </div>
</div>
<script>
    new Vue({
        el: "#app",
        data: function () {
            return {
                title: "个人设置",
                activeTab: null,
                baseInfo: [],
                formInline: {
                    user: '',
                    password: '',
                },
                ruleInline: {
                    user: [
                        {required: true, message: 'Please fill in the user name', trigger: 'blur'}
                    ],
                    password: [
                        {required: true, message: 'Please fill in the password.', trigger: 'blur'},
                        {
                            type: 'string',
                            min: 6,
                            message: 'The password length cannot be less than 6 bits',
                            trigger: 'blur'
                        }
                    ]
                }

            }
        },
        mounted() {
            this.baseInfo = [{name: "基本设置", deslabel: "个人信息账户设置"}, {name: "安全设置", deslabel: "密码，邮箱设置"},
                {name: "账号绑定", deslabel: "绑定第三方社交账户"}]
            this.activeTab = "基本设置"
        },
        created() {

        },
        methods: {
            settingChang(name) {
                this.activeTab = name//设置tabs的activeTab
            }
        },

    });
</script>
