$(function() {
  // ロード時に県が選ばれているとき
  $('#search_prefecture').each(function() {
    pr_name = $(this).val();
    append_city_option(pr_name);
  })

  // select_boxが選択された時
  $(document).on('change', '#search_prefecture', function() {
    pr_name = $(this).val();
    append_city_option(pr_name);
  })

  function append_city_option(pr_name) {
    if (pr_name == "") {
      // 選択肢の入れ替え
      $('#search_city option').remove();
      let $option_tag = $('<option>').val("").text("選択してください");
      $('#search_city').append($option_tag);
    } else {
      let pr_code = get_pr_code(pr_name);
      // APIでcityを取得
      $.ajax({
        type: "GET",
        url: `https://www.land.mlit.go.jp/webland/api/CitySearch?area=${pr_code}`
      }).done(function (json) {
        let data = json['data']
        let city_list = [...data].map(value => value.name);
        // 選択肢の入れ替え
        $('#search_city option').remove();
        let $option_tag = $('<option>').val("").text("選択してください");
        $('#search_city').append($option_tag);
        city_list.forEach(function (name) {
          let $option_tag = $('<option>').val(name).text(name);
          $('#search_city').append($option_tag);
        });
        // ロード時に1回だけ，クエリにあるcityを選択する
        if (!$('#search_city').hasClass('fire')) {
          let path_search = location.search;
          let selected_city = decodeURI(path_search.match(/city_or_town_cont%.*/g)[0].replace('city_or_town_cont%5D=', '').replace('&commit=%E6%A4%9C%E7%B4%A2',''));
          $('#search_city').val(selected_city);
          $('#search_city').addClass('fire');
        }
      }).fail(function () {
        alert('エラーが発生しました');
      })
    }
  }

  function get_pr_code(pr_name) {
    let prefecture = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
    let index = prefecture.indexOf(pr_name) + 1
    let pr_code = ("0" + index).slice(-2)
    return pr_code
  }
});
