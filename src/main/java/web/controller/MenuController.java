package web.controller;


import com.baidu.translate.demo.TransApi;
import domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import query.MenuQuery;
import service.IMenuService;
import util.ConstantApi;
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

    /**
     * 初始化的菜单
     *
     * @return
     */
    @RequestMapping("/findAll")
    @ResponseBody
    public List<Menu> findAll() {
        return menuService.findAll();
    }

    /**
     * 菜单管理查询的菜单
     *
     * @param menuQuery
     * @return
     */
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

    /**
     * 查询菜单名称是否重复
     *
     * @param name
     * @return
     */
    @RequestMapping("/findByName")
    @ResponseBody
    public Menu findOne(String name) {
        SqlParam sqlParam = new SqlParam();
        sqlParam.setCloum("name");
        sqlParam.setValue(name);
        return menuService.findOne(sqlParam);
    }

    /**
     * 删除菜单
     *
     * @param ids
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Long[] ids) {
        for (long id : ids) {
            menuService.delete(id);
        }

        return "";
    }

    /**
     * 添加菜单
     *
     * @param menu
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public Menu save(Menu menu) {
        Menu newMenu = menuService.findOne(menuService.save(menu));
        return newMenu;/*返回添加的对象*/
    }

    /**
     * 修改方法，并且返回当前修改菜单的所有父菜单
     *
     * @param menu
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public List<String> update(Menu menu) {
        menuService.update(menu);/*修改后返回其父菜单，用于打开父菜单*/
        SqlParam sqlParam = new SqlParam();
        sqlParam.setCloum("id");
        sqlParam.setValue(String.valueOf(menu.getParent())); /*如果直接返回null的话，ajax的success方法不会执行*/
        List<String> allParentName = menuService.findAllParent(sqlParam);/*list中只添加了名字，可以自行添加整个菜单*/
        return allParentName;
    }

    /**
     * 到菜单新加和删除界面
     *
     * @return
     */
    @RequestMapping("/forwardMenuEdit")
    public String forwardMenuEdit() {/*返回到添加页面*/
        return "WEB-INF/admin/menulist/edit";
    }

    /**
     * 百度翻译Api
     *
     * @param name
     * @return
     */
    @RequestMapping("/getEnglishNameByBaiduApi")
    @ResponseBody
    public String getEnglishNameByBaiduApi(String name) {
        TransApi api = new TransApi(ConstantApi.BaiduFanyi_APP_ID, ConstantApi.BaiduFanyi_SECURITY_KEY);
        String transResult = api.getTransResult(name, "auto", "en");
        return transResult;
    }

}
