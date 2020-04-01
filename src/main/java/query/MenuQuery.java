package query;

import org.springframework.util.StringUtils;
import util.Paging;

import java.sql.Timestamp;

public class MenuQuery extends Paging {
    private String name;
    private String time;/*查询的字段*/

    public String getWhereSql() {
        StringBuilder sb = new StringBuilder();
        if (StringUtils.hasLength(name)) {
            sb.append(" and name like '%" + name + "%'");
        }
       /* if (StringUtils.hasLength(time)) {
            System.out.println(time);

        }*/
        return sb.toString();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        System.out.println(time);
        this.time = time;
    }
}
