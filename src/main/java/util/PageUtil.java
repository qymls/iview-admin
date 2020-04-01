package util;

import java.util.List;

public class PageUtil<T> {
    /**
     * 首页
     */
    private Integer firstPage;
    /**
     * 最后一页
     */
    private Integer lastPage;
    /**
     * 当前第几页
     */
    private Integer page;
    /**
     * 一页多少条数据
     */
    private Integer pageSize;
    /**
     * 总记录数
     */
    private Integer totalRows;
    /**
     * 总页数
     */
    private Integer totalPage;
    /**
     * 下一页
     */
    private Integer nextPage;
    /**
     * 上一页
     */
    private Integer prePage;

    /**
     * 传递值，总记录数，等计算
     */
    private List<T> list;

    public PageUtil() {
    }

    public PageUtil(Integer page, Integer pageSize, Integer totalRows) {
        this.firstPage = 1;
        this.page = page < 1 ? 1 : page;/*处理用户手动输入的情况*/
        this.pageSize = pageSize < 1 ? 10 : pageSize;/*可以不判断*/
        this.totalRows = totalRows;
        /*计算总页数（总记录数+页面大小-1）/页面大小*/
        this.totalPage = (this.totalRows + this.pageSize - 1) / this.pageSize;
        this.page = this.page > this.totalPage ? this.totalPage : this.page;/*处理用户手动输入的情况*/
        /*下一页如果是最后一页，就是当前页*/
        this.nextPage = (this.page + 1) > totalPage ? totalPage : this.page + 1;
        /*上一页是第一页那么上一页就是第一页*/
        this.prePage = (this.page - 1) < 1 ? 1 : this.page - 1;
        this.lastPage = totalPage;

    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public Integer getFirstPage() {
        return firstPage;
    }

    public Integer getLastPage() {
        return lastPage;
    }

    public Integer getPage() {
        return page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public Integer getTotalRows() {
        return totalRows;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public Integer getNextPage() {
        return nextPage;
    }

    public Integer getPrePage() {
        return prePage;
    }

    public List<T> getList() {
        return list;
    }
}
