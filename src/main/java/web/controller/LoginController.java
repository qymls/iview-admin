package web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import util.Constant;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/Admin")
public class LoginController {

    /**
     * 跳转登录页面
     *
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "WEB-INF/admin/login";
    }

    /**
     * 登录方法
     *
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(String username, String password, HttpSession session) {
        session.setAttribute(Constant.LOGIN_SESSION, username);
        HashMap<String, Object> map = new HashMap<>();
        return map;
    }

    /**
     * 注销方法
     *
     * @param session
     */
    @RequestMapping("/logout")
    @ResponseBody
    public String logout(HttpSession session) {
        session.removeAttribute(Constant.LOGIN_SESSION);
        return "";
    }

    /**
     * qq登录
     */
    @RequestMapping("/qqLoginSendPost")
    public void qqLoginSendPost() {

    }

    @RequestMapping("/qqLoginAccessToken")
    public void qqLoginAccessToken(String code) {
        System.out.println(code);
    }

}
