# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2017-2018, Sebastian Staudt

require 'rails_helper'

describe FormulaeHelper do

  describe '#code_link' do
    it 'returns a correct link to commit’s formula code' do
      formula = mock path: 'Formula/git.rb'
      revision = mock sha: 'deadbeef'

      expect(helper.code_link(formula, revision)).to eq('<a target="_blank" href="https://github.com/Homebrew/homebrew-core/blob/deadbeef/Formula/git.rb">Formula code</a>')
    end
  end

  describe '#formula_diff_link' do
    it 'returns a correct link to the commit’s diff of the formula' do
      formula = mock path: 'Formula/git.rb'
      revision = mock sha: 'deadbeef'

      expect(helper.formula_diff_link(formula, revision)).to eq('<a target="_blank" href="https://github.com/Homebrew/homebrew-core/commit/deadbeef#diff-3e84bae646d908b93e043833873d316d"></a>')
    end
  end

  describe '#history_link' do
    it 'returns a correct link to the formula’s history on GitHub' do
      formula = mock path: 'Formula/git.rb'

      expect(helper.history_link(formula)).to eq('<a target="_blank" href="https://github.com/Homebrew/homebrew-core/commits/HEAD/Formula/git.rb">Complete formula history at GitHub</a>')
    end
  end

  describe '#letters' do
    it 'returns all available letters' do
      Repository.stubs(:all).returns [mock(letters: %w[A B C])]

      expect(helper.letters).to eq(%w[A B C])
    end
  end

end
