package dao;

import domain.Menu;
import query.MenuQuery;
import util.SqlParam;

import java.util.List;

public interface IMenuDao {
    List<Menu> findAll();

    List<Menu> getStairMenu(MenuQuery menuQuery);

    Integer getTotalCount(MenuQuery menuQuery);

    Menu findOne(long id);

    void delete(long id);

    int save(Menu jobs);

    void update(Menu jobs);

    List<Menu> getStairMenu();

    Menu findOne(SqlParam sqlParam);

}
