every 1.day, :at => '12:25 pm' do
  rake "sunspot:solr:reindex"
end