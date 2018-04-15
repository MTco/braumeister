# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2017-2018, Sebastian Staudt

require 'repository_import'

module MainImport

  include RepositoryImport

  def update_status
    last_sha = super

    save! if last_sha != sha

    last_sha
  end

end
