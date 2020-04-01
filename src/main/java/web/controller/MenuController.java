package web.controller;


import domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import query.MenuQuery;
import service.IMenuService;
import util.PageUtil;
import util.SqlParam;

import java.util.List;

@Controller
@RequestMapping("/Admin/Menu")
public class MenuController {
    private IMenuService menuService;

    @Autowired
    public void setMenuService(IMenuService menuService) {
        this.menuService = menuService;
    }

    @RequestMapping("/findAll")
    @ResponseBody
    public List<Menu> findAll() {
        return menuService.findAll();
    }

    @RequestMapping("/findAllMenu")
    @ResponseBody
    public PageUtil<Menu> findAllMenu(MenuQuery menuQuery) {
        return menuService.findAll(menuQuery);
    }


    @RequestMapping("/findOne")
    public String findOne(Model model, Long id) {
        Menu menu = menuService.findOne(id);
        model.addAttribute("menu", menu);
        return "WEB-INF/views/menu/menu_add";
    }

    @RequestMapping("/findByName")
    @ResponseBody
    public Menu findOne(String name) {
        SqlParam sqlParam = new SqlParam();
        sqlParam.setCloum("name");
        sqlParam.setValue(name);
        return menuService.findOne(sqlParam);
    }


    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Long[] ids) {
        for (long id : ids) {
            menuService.delete(id);
        }

        return "";
    }

    @RequestMapping("/save")
    @ResponseBody
    public Menu save(Menu menu) {
        Menu newMenu = menuService.findOne(menuService.save(menu));
        return newMenu;/*返回添加的对象*/
    }

    @RequestMapping("/update")
    public String update(Menu menu) {
        menuService.update(menu);
        return "redirect:findAll";
    }

    @RequestMapping("/forwardMenuEdit")
    public String forwardMenuEdit() {/*返回到添加页面*/
        return "WEB-INF/admin/menulist/edit";
    }


}
