module VideosHelper

  def videos_index_json(videos)
    videos.map do |video|
      {
        id: video.id,
        title: video.title,
        url: video.url,
        kind_of: video.kind_of,
        rate: video.rate,
        mvp: video.mvp,
        updated_on: video.updated_on,
        random_tags: video.random_tags,
        users: video.users_id_select  #users_id_selectはvideoモデルにて定義
      }
    end.to_json
  end

end
