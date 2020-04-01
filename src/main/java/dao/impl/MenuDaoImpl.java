package dao.impl;

import dao.IMenuDao;
import domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import query.MenuQuery;
import util.SqlParam;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public class MenuDaoImpl implements IMenuDao {
    private JdbcTemplate jdbcTemplate;

    @Autowired/*自动装载jdbcTemplate*/
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Menu> findAll() {
        String sql = "select * from menu";
        List<Menu> menuList = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Menu.class));
        return menuList;
    }

    @Override
    public List<Menu> getStairMenu(MenuQuery menuQuery) {
        String sql = "select * from menu where parent = 0" + menuQuery.getWhereSql() + " limit ?,?";
        List<Menu> menuList = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Menu.class), menuQuery.start(), menuQuery.getPageSize());
        return menuList;
    }

    @Override
    public Integer getTotalCount(MenuQuery menuQuery) {
        String sql_total = "select count(*) as totalCount  from menu where parent = 0 " + menuQuery.getWhereSql();
        Map<String, Object> stringObjectMap = jdbcTemplate.queryForMap(sql_total);
        int totalCount = Integer.parseInt(stringObjectMap.get("totalCount").toString());
        return totalCount;
    }

    @Override
    public List<Menu> getStairMenu() {
        String sql = "select * from menu where parent =0";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Menu.class));
    }


    @Override
    public Menu findOne(long id) {
        String sql = "select * from menu where id = ?";
        Menu menu = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Menu.class), id);
        return menu;
    }

    @Override
    public Menu findOne(SqlParam sqlParam) {
        String sql = "select * from menu " + sqlParam.getSql();

        Menu menu = null;
        try {
            menu = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Menu.class));
        } catch (EmptyResultDataAccessException e) {/*捕获异常就返回空*/
            return null;
        } catch (IncorrectResultSizeDataAccessException e) {/*当查询结果大于1，说明有多个结果*/
            System.out.println("数据库中存在多条数据");
            System.out.println(sql);
        }
        return menu;
    }


    @Override
    public void delete(long id) {
        String sql = "delete from menu where id =?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int save(Menu menu) {
        String sql = "insert into menu (name, label, Icon, url, english_name, operator, create_time,parent, description) VALUE (?,?,?,?,?,?,?,?,?)";
       /* jdbcTemplate.update(sql, menu.getName(), menu.getName(), menu.getIcon(), menu.getUrl(), menu.getEnglishName(),
                menu.getOperator(), new Timestamp(System.currentTimeMillis()), menu.getParent(), menu.getDescription());*/
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(conn -> {
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setObject(1, menu.getName());
            ps.setObject(2, menu.getName());
            ps.setObject(3, menu.getIcon());
            ps.setObject(4, menu.getUrl());
            ps.setObject(5, menu.getEnglishName());
            ps.setObject(6, menu.getOperator());
            ps.setObject(7, new Timestamp(System.currentTimeMillis()));
            ps.setObject(8, menu.getParent());
            ps.setObject(9, menu.getDescription());
            return ps;
        }, keyHolder);
        return keyHolder.getKey().intValue();/*返回插入的主键id*/

    }

    @Override
    public void update(Menu menu) {
    }


}
