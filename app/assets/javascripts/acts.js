(function () {

  /* When creating a new act */
  var bindActCreators = function () {
    $(".act-creator").click(function (e) {
      e.preventDefault();
      $(".act-creator").each(function () {
        $(this).removeClass("btn-success").addClass("btn-default");
      });
      $(this).removeClass("btn-default").addClass("btn-success");
      var arr = $(this).attr('id').split('-');
      $("#act_activity_id").val(arr[arr.length-1]);
    });
  };

  $(function () {
    bindActCreators();
  });

})();