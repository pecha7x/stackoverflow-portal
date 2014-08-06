user =
  init: ->
    _.templateSettings =  interpolate :/\{\{(.+?)\}\}/g
    @getQuestions()

  getQuestions: ->
    $('#check-question').on "click", ->
      $(".question").remove()
      username = $('#username').val()
      if username is ''
        $(".alert").remove()
        return $("#result").append "<div class='alert alert-danger'>Please enter a valid username</div>"
      $.ajax(
        type: "post"
        url: "/get_questions.json"
        data: {
          username
        }
        dataType: "json"
      ).done (data) ->
        $(".alert").remove()
        if data.not_errors
          $.each data.questions.items, (i, e) ->
            quest = _.template(  $.trim($("#question").html()), {title: e.title, tags: e.tags, link: e.link})
            $("#result").prepend(quest)
        else
          $("#result").append "<div class='alert alert-danger'>This user not exist on StackOverflow</div>"

      setTimeout "$('.alert').hide();", 4000
$ ->
  user.init()