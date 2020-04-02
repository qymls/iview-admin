package service.impl;

import dao.IMenuDao;
import domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import query.MenuQuery;
import service.IMenuService;
import util.PageUtil;
import util.SqlParam;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@Service
public class MenuServiceImpl implements IMenuService {
    private IMenuDao menuDao;

    @Autowired
    public void setMenuDao(IMenuDao menuDao) {
        this.menuDao = menuDao;
    }

    /**
     * 初始化菜单管理
     *
     * @return
     */
    @Override
    public List<Menu> findAll() {
        List<Menu> menuList = menuDao.findAll();
        List<Menu> stairMenuList = menuDao.getStairMenu();
        for (Menu stairMenu : stairMenuList) {
            stairMenu.setUrl("Admin/jframeUrl?url=" + stairMenu.getUrl());/*特殊处理下url，用于放在web-info下时请求不需要的可以换个地方*/
            stairMenu.setChildren(getMenuTree(menuList, stairMenu.getId()));/*一级菜单*/
        }
        return stairMenuList;
    }

    /**
     * 给一级菜单添加子菜单，递归，文件都放在web-info下的，所以需要加上请求，用于菜单初始化
     *
     * @param menuList
     * @param id
     * @return
     */
    private List<Menu> getMenuTree(List<Menu> menuList, Long id) {
        List<Menu> treeList = new ArrayList<>();
/*        menuList.forEach(menu -> {
            if (Objects.equals(id, menu.getParent())) {
                menu.setChildren(getMenuTree(menuList, menu.getId()));
                treeList.add(menu);
            }
        });*/
        for (Menu menu : menuList) {/*将所有菜单的parentid和传递的菜单id对比，相等就递归调用，并且加到treeList中，用于setChildren*/
            if (id.equals(menu.getParent())) {/*可能出现空指的放在后面*/
                menu.setUrl("Admin/jframeUrl?url=" + menu.getUrl());/*特殊处理下url，用于放在web-info下时请求*/
                menu.setChildren(getMenuTree(menuList, menu.getId()));
                treeList.add(menu);
            }

        }
        return treeList;
    }

    /**
     * 菜单管理界面
     *
     * @param menuQuery
     * @return
     */

    @Override
    public PageUtil<Menu> findAll(MenuQuery menuQuery) {
        List<Menu> menuList = menuDao.findAll();
        Integer totalCount = menuDao.getTotalCount(menuQuery);
        if (totalCount == 0) {
            return new PageUtil<>();
        }
        PageUtil<Menu> menuPageUtil = new PageUtil<>(menuQuery.getPage(), menuQuery.getPageSize(), totalCount);
        menuQuery.setPage(menuPageUtil.getPage());
        menuQuery.setPageSize(menuPageUtil.getPageSize());/*纠正了page和pagesize可能的错误*/
        List<Menu> stairMenuList = menuDao.getStairMenu(menuQuery);
        for (Menu stairMenu : stairMenuList) {
            stairMenu.setChildren(getMenuTreeMenu(menuList, stairMenu.getId()));/*一级菜单*/
        }
        menuPageUtil.setList(stairMenuList);
        return menuPageUtil;
    }


    /**
     * 菜单管理，不用初始化菜单，不需要特殊处理url
     *
     * @param menuList
     * @param id
     * @return
     */
    private List<Menu> getMenuTreeMenu(List<Menu> menuList, Long id) {
        List<Menu> treeList = new ArrayList<>();
        for (Menu menu : menuList) {/*将所有菜单的parentid和传递的菜单id对比，相等就递归调用，并且加到treeList中，用于setChildren*/
            if (id.equals(menu.getParent())) {/*可能出现空指的放在后面*/
                menu.setChildren(getMenuTreeMenu(menuList, menu.getId()));
                treeList.add(menu);
            }
        }
        return treeList;
    }


    @Override
    public Menu findOne(long id) {
        return menuDao.findOne(id);
    }

    /**
     * 根据sql条件，只查找一个对象，要么是null，要么是一个Menu对象
     *
     * @param sqlParam
     * @return
     */
    @Override
    public Menu findOne(SqlParam sqlParam) {
        return menuDao.findOne(sqlParam);
    }

    /**
     * 获取一个子菜单所有的父菜单
     *
     * @param sqlParam
     * @return
     */
    @Override
    public List<String> findAllParent(SqlParam sqlParam) {
        List<String> menuListParent = new LinkedList<>();
        Menu menu = menuDao.findOne(sqlParam);
        if (menu != null) {
            menuListParent.add(menu.getName());
            getPartnt(menu.getParent(), sqlParam, menuListParent);
        }
        return menuListParent;
    }

    /**
     * 递归查找所有的父菜单,装到list中
     *
     * @param parent
     * @param sqlParam
     * @param list
     */
    public void getPartnt(Long parent, SqlParam sqlParam, List<String> list) {
        sqlParam.setCloum("id");
        sqlParam.setValue(String.valueOf(parent));
        Menu menu = menuDao.findOne(sqlParam);
        if (menu != null) {
            list.add(menu.getName());
            getPartnt(menu.getParent(), sqlParam, list);
        }

    }


    /**
     * 删除菜单
     *
     * @param id
     */
    @Override
    public void delete(long id) {
        menuDao.delete(id);

    }

    /**
     * 保存菜单
     *
     * @param menu
     * @return
     */
    @Override
    public int save(Menu menu) {
        return menuDao.save(menu);
    }

    @Override
    public void update(Menu menu) {
        menuDao.update(menu);
    }


}
