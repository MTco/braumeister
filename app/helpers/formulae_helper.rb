# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2017-2018, Sebastian Staudt

require 'digest'

module FormulaeHelper

  def code_link(formula, revision)
    link_to 'Formula code', "https://github.com/#{Repository::CORE}/blob/#{revision.sha}/#{formula.path}", target: :_blank
  end

  def formula_diff_link(formula, rev)
    diff_md5 = Digest::MD5.hexdigest formula.path
    link_to '', "https://github.com/#{Repository::CORE}/commit/#{rev.sha}#diff-#{diff_md5}", target: :_blank
  end

  def history_link(formula)
    link_to 'Complete formula history at GitHub', "https://github.com/#{Repository::CORE}/commits/HEAD/#{formula.path}", target: :_blank
  end

  def letters
    if all?
      Repository.all.map(&:letters).flatten.uniq.sort
    else
      @repository.letters
    end
  end

  def name
    all? ? nil : @repository.name
  end

end
