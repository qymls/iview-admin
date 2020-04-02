package query;

import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
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
        if (StringUtils.hasLength(time)) {
            if (!",".equals(time)) {/*处理区间段是空，也会有个，号的*/
                String start_time = time.split(",")[0];
                String end_time = time.split(",")[1];
                sb.append(" and create_time > '" + start_time + "' and create_time < '" + end_time + "'");
            }
        }
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
        this.time = time;
    }
}
