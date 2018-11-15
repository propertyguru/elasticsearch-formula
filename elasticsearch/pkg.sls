{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

{% if elasticsearch_map.use_repo %}
include:
  - elasticsearch.repo
{% endif %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {% if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {% endif %}
    {% if elasticsearch_map.hold %}
    - hold: True # Hold package from auto upgrading as some custom plugins are built for specific versions
    {% endif %}
    {% if elasticsearch_map.use_repo %}
    - require:
      - sls: elasticsearch.repo
    {% endif %}
