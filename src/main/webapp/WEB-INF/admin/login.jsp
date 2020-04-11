<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="iview/iview.css">
    <script src="iview/vue.js"></script>
    <script src="iview/iview.min.js"></script>
    <script src="iview/jquery-3.4.1.min.js"></script>

    <style>
        body, #app {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #app {
            background-color: #97979514;
        }

        h2 {
            margin-bottom: 25px;
            text-align: center;
            font-size: 24px;
        }

        form {
            width: 300px;
        }
    </style>
</head>
<body>
<div id="app" style="width: 500px;height: 600px">
    <i-Form ref="formInline" :model="formInline" :rules="ruleInline">
        <Form-Item>
            <h2>欢迎登录</h2>
        </Form-Item>
        <Form-Item prop="user">
            <i-Input type="text" size="large" v-model="formInline.user" placeholder="Username">
                <Icon type="ios-contact" slot="prefix"/>
            </i-Input>
        </Form-Item>
        <Form-Item prop="password">
            <i-Input type="password" password size="large" v-model="formInline.password" placeholder="Password">
                <Icon type="ios-lock" slot="prefix"></Icon>
            </i-Input>
        </Form-Item>
        <Form-Item prop="interest">
            <Checkbox-Group v-model="formInline.interest">
                <Checkbox label="记住密码"></Checkbox>

            </Checkbox-Group>
        </Form-Item>
        <Form-Item>
            <i-Button type="primary" size="large" long @click="handleSubmit('formInline')">登录</i-Button>
        </Form-Item>
        <Form-Item>
            <div style="text-align: center">
                <div style=" width: auto; display: inline-block;">
                    <a href="https://github.com/login/oauth/authorize?client_id=3ca472fea411731bca58&state=github"
                       style="{right: 26px;}">
                        <img class="icon" src="admin/images/GitHub.svg" style="width: 35px;height: 40px;"/>
                    </a>
                </div>
                <div style=" width: auto; display: inline-block;">
                    <a href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101525509&redirect_uri=http://127.0.0.1/Admin/qqLoginAccessToken&state=qq"
                       style="{right: 26px;}">
                        <img class="icon" src="admin/images/social-qq.svg" style="width: 35px;height: 40px;"/>
                    </a>
                </div>
            </div>
        </Form-Item>
    </i-Form>

</div>

<script>
    new Vue({
        el: '#app',
        data: {
            formInline: {
                user: 'admin',
                password: '123456'
            },
            ruleInline: {
                user: [
                    {required: true, message: '请输入您的用户名', trigger: 'blur'}
                ],
                password: [
                    {required: true, message: '请输入密码', trigger: 'blur'},
                    {type: 'string', min: 6, message: '密码需要超过6位', trigger: 'blur'}
                ]
            }
        },
        create: {},
        methods: {
            handleSubmit(name) {
                $page = this;
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/x-www-form-urlencoded",
                            url: "Admin/qqLoginSendPost",
                            data: {
                                "username": this.formInline.user,
                                "password": this.formInline.password
                            },
                            dataType: 'json',
                            success: function (result) {
                                /* window.location.href = "Admin/admin";*/
                            }
                        });

                    }
                })
            }
        }
    })
</script>
</body>
</html>
