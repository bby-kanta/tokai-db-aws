// グローバルメソッドを定義
export default {    // exportする
  created() {
      console.log('start! from mixins.')    // 起動後必ずログが出力される
  },

  data() {
      return {
          serverPass: "https://toukaionair.com",    // サーバーサイドのパスを定義
      }
  },

  methods: {
    random(array, num) {  //配列から特定の数だけ取り出すメソッド
      var a = array;
      var t = [];
      var r = [];
      var l = a.length;
      var n = num < l ? num : l;
      while (n-- > 0) {
        var i = Math.random() * l | 0;
        r[n] = t[i] || a[i];
        --l;
        t[i] = t[l] || a[l];
      }
      return r;
    },

    users_id: function() { //users_idにはvideoのusersのidがシンプルな配列で入る→ 連想配列では無くなったのでincludesメソッドが使える
      var users = this.video.users;  //例）"video.users":[{"id":1},{"id":2}]
      var user = this.user;
      var users_id = [];
      var hoge = [];

      for(hoge in users){
        users_id.push(users[hoge].id);  //例）users_id = [1,2]
      }

      // console.log(users_id);
      // console.log(users_id.includes(user));
      return users_id 
    },

  },

  computed: {

  },
}