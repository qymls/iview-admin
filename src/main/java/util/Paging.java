package util;


public class Paging {
    /**
     * 当前第几页
     */
    private Integer page = 1;
    /**
     * 读取条数
     */
    private Integer pageSize = 10;

    public Paging() {
    }

    public Integer start() {
        return (this.page - 1) * this.pageSize;
    }


    public Integer getPage() {
        return page;

    }

    public void setPage(Integer page) {
        if (page == null) {
            page = 1;
        }
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        if (pageSize == null) {
            pageSize = 10;
        }
        this.pageSize = pageSize;
    }

}
