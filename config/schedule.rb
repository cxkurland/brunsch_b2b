every 1.day, :at => '11:15 am' do
  rake "sunspot:solr:reindex"
end