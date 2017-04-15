namespace :doc do
  desc "Generate document."
  task generate: :environment do
    json = SchemaRepresentation.to_json_schema
    schema = JSON.parse(json)
    md = Jdoc::Generator.call(schema)
    #html = Jdoc::Generator.call(schema, html: true)
    #File.write("doc/overview.json", json)
    File.write("doc/overview.md", md)
    #File.write("doc/overview.html", html)
  end
end
