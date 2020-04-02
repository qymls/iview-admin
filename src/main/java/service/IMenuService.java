package service;

import domain.Menu;
import query.MenuQuery;
import util.PageUtil;
import util.Paging;
import util.SqlParam;

import java.util.LinkedList;
import java.util.List;


public interface IMenuService {
    List<Menu> findAll();

    PageUtil<Menu> findAll(MenuQuery menuQuery);

    Menu findOne(long id);

    void delete(long id);

    int save(Menu menu);

    void update(Menu menu);

    Menu findOne(SqlParam sqlParam);

    List<String> findAllParent(SqlParam sqlParam);
}
