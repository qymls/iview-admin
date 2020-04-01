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
import java.util.List;

@Service
public class MenuServiceImpl implements IMenuService {
    private IMenuDao menuDao;

    @Autowired
    public void setMenuDao(IMenuDao menuDao) {
        this.menuDao = menuDao;
    }

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
            stairMenu.setUrl("Admin/jframeUrl?url=" + stairMenu.getUrl());/*特殊处理下url，用于放在web-info下时请求不需要的可以换个地方*/
            stairMenu.setChildren(getMenuTree(menuList, stairMenu.getId()));/*一级菜单*/
        }
        menuPageUtil.setList(stairMenuList);
        return menuPageUtil;
    }


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


    @Override
    public Menu findOne(long id) {
        return menuDao.findOne(id);
    }

    @Override
    public Menu findOne(SqlParam sqlParam) {
        return menuDao.findOne(sqlParam);
    }

    @Override
    public void delete(long id) {
        menuDao.delete(id);

    }

    @Override
    public int save(Menu menu) {
        return menuDao.save(menu);
    }

    @Override
    public void update(Menu menu) {
        menuDao.update(menu);
    }


}
