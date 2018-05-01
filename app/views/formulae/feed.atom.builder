# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2012-2018, Sebastian Staudt

atom_feed :id => "tag:formulae.brew.sh,2012:all",
          :schema_data => 2012,
          'xmlns:opensearch' => 'http://a9.com/-/spec/opensearch/1.1/' do |feed|

  feed.title 'Formula updates – formulae.brew.sh'

  feed.link rel: 'search', href: '/opensearch.xml', title: 'formulae.brew.sh – Search',
            type: 'application/opensearchdescription+xml'
  feed.link rel: 'shortcut icon', href: 'data:image/x-icon;,',
            type: 'image/x-icon'

  add_entry = ->(status, formula, revision) do
    entry_options = {
      id: "tag:formulae.brew.sh,2012:#{Repository::CORE}/#{formula.name}-#{revision.sha}",
      updated:   revision.date,
      url: formula.dupe? ? polymorphic_path([formula.repository, formula]) : polymorphic_path(formula)
    }

    feed.entry formula, entry_options do |entry|
      entry.title "#{formula.name} has been #{status}"
      entry.summary revision.subject

      entry.author do |author|
        author.name revision.author.name
      end
    end
  end

  @revisions.includes(:author, :added_formulae, :updated_formulae, :removed_formulae).each do |revision|
    revision.added_formulae.each { |formula| add_entry.call('added', formula, revision) }
    revision.updated_formulae.each { |formula| add_entry.call('updated', formula, revision) }
    revision.removed_formulae.each { |formula| add_entry.call('removed', formula, revision) }
  end
end
