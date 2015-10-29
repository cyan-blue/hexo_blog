{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}
{% block title %} {{ config.title }} {% endblock %}

{% block page_class %}
  {% if is_home() %} page-home {% endif %}
{% endblock %}

{% block content %}
    <div id="lunbocontainer"> </div>
    <link rel="stylesheet" type="text/css" href="http://huangyan.qiniudn.com/blogstyle.css" />
    <script src='http://huangyan.qiniudn.com/delaunay.js'></script>
    <script src='http://huangyan.qiniudn.com/TweenMax.js'></script>
    <script src='http://huangyan.qiniudn.com/yannlunbo.js'></script>
  <section id="posts" class="posts-expand">
    {% for post in page.posts %}
      {{ post_template.render(post, true) }}
    {% endfor %}
  </section>

  {% include '_partials/pagination.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}