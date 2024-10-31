# Formula

Formula is a Rails form helper that generates awesome markup. The project lets users create semantically beautiful forms without introducing too much syntax.

## Requirements

The gem is tested with:

- Ruby 3.3
- Rails 7.2

## Installation

```bash
gem install formula
```

## Examples

```erb
<%= formula_form_for @user do |f| %>
  <%= f.input :email %>
  <%= f.input :password %>
  <%= f.button 'Save' %>
<% end %>
```

```erb
<%= formula_form_for @user do |f| %>
  <%= f.input :email, label: "Email:", hint: "We promise never to bother you." %>
  <%= f.input :password, label: "Password:", hint: "Must be at least six characters." %>
  <%= f.button 'Save' %>
<% end %>
```

```erb
<%= formula_form_for @company do |f|
  <%= f.input :url, container: { class: 'third' }, input: { class: 'fill' } %>
  <%= f.input :phone, container: { class: 'third' }, input: { class: 'fill' } %>
  <%= f.input :email, container: { class: 'third' }, input: { class: 'fill' } %>
  <%= f.button 'Save', button: { class: 'fancy' } %>
<% end %>
```

```erb
<%= formula_form_for @user do |f| %>
  <%= f.input :email, label: "Email:" %>
  <%= f.input :password, label: "Password:" %>
  <%= f.input :gender, label: 'Gender:', as: :select, choices: User::GENDERS %>
  <%= formula_fields_for @user.payment do |payment_f| %>
    <%= payment_f.input :credit_card_number, label: 'Number:' %>
    <%= payment_f.input :credit_card_expiration, label: 'Expiration:' %>
  <% end %>
  <%= f.button 'Save', button: { class: 'fancy' } %>
<% end %>
```

```erb
<%= formula_form_for @user do |f| %>
  <%= f.block :favourite %>
    <% @favourites.each do |favourite| %>
      ...
    <% end %>
  <% end %>
  <%= f.button 'Save', button: { class: 'fancy' } %>
<% end %>
```

## Status

[![Dependency Status](http://img.shields.io/gemnasium/ksylvest/formula.svg)](https://gemnasium.com/ksylvest/formula)
[![Build Status](http://img.shields.io/travis/ksylvest/formula.svg)](https://travis-ci.org/ksylvest/formula)
[![Code Climate](http://img.shields.io/codeclimate/github/ksylvest/formula.svg)](https://codeclimate.com/github/ksylvest/formula)

## Copyright

Copyright (c) 2010 - 2024 Kevin Sylvestre. See LICENSE for details.
