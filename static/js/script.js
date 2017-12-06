//搜索
function search_work() {
    window.location = "/?q=" + encodeURIComponent($("#id_search_input").val());
}
$("#id_search_input").keyup(function (event) {
    if (event.keyCode == 13) {
        window.location = "/?q=" + encodeURIComponent($("#id_search_input").val());
    }
});

//设置分类选中状态
$("#category a[href='/"+location.search+"']").addClass("active");