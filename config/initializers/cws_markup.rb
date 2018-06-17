# frozen_string_literal: true

module RubyBBCode
  # Extensions to the official BBcode tags for CWS markup tags
  module Tags
    # tagname => tag, HTML open tag, HTML close tag, description, example
    # TODO: THIS NEEDS TO BE DONE STILL (gblock)
    @@tags[:gblock] = {
      html_open: '<div style="color: purple;"><strong>This is a test!</strong> ', html_close: '</div>',
      description: 'I am just testing things out',
      example: '[test]Just testing things![/test]'
    }

    @@tags[:table] = {
      html_open: '<table class="table table-sm">', html_close: '</table>',
      description: 'Define a table',
      example: '[table][row][col]John[/col][col]26 Blueberry Lane, Pickletown[/col][/row][/table]'
    }

    @@tags[:rowhead] = {
      html_open: '<th scope="row" rowspan="%rowspan%" colspan="%colspan%">', html_close: '</th>',
      description: 'Define a table cell which acts as the header of its row',
      example: '[table][row][rowhead]John[/rowhead][col]26 Blueberry Lane, Pickletown[/col][/row][/table]',
      allow_quick_param: true, allow_between_as_param: false,
      quick_param_format: /[0-9]+/,
      param_tokens: [
        { token: :colspan, default: '1', optional: true },
        { token: :rowspan, default: '1', optional: true }
      ]
    }

    @@tags[:colhead] = {
      html_open: '<th scope="col" colspan="%colspan%" rowspan="%rowspan%">', html_close: '</th>',
      description: 'Define a table cell which acts as the header of its column',
      example: '[table][row][colhead]Name[/colhead][colhead]Address[/colhead][/row][/table]',
      allow_quick_param: true, allow_between_as_param: false,
      quick_param_format: /[0-9]+/,
      param_tokens: [
        { token: :colspan, default: '1', optional: true },
        { token: :rowspan, default: '1', optional: true }
      ]
    }

    @@tags[:row] = {
      html_open: '<tr rowspan="%rowspan%" colspan="%colspan%">', html_close: '</tr>',
      description: 'Define a row of a table',
      example: '[table][row][col]John[/col][col]26 Blueberry Lane, Pickletown[/col][/row][/table]',
      allow_quick_param: true, allow_between_as_param: false,
      quick_param_format: /[0-9]+/,
      param_tokens: [
        { token: :colspan, default: '1', optional: true },
        { token: :rowspan, default: '1', optional: true }
      ]
    }

    @@tags[:col] = {
      html_open: '<td colspan="%colspan%" rowspan="%rowspan%">', html_close: '</td>',
      description: 'Define a table cell (column) within a row',
      example: '[table][row][col]John[/col][col]26 Blueberry Lane, Pickletown[/col][/row][/table]',
      allow_quick_param: true, allow_between_as_param: false,
      quick_param_format: /[0-9]+/,
      param_tokens: [
        { token: :colspan, default: '1', optional: true },
        { token: :rowspan, default: '1', optional: true }
      ]
    }

    @@tags[:big] = {
      html_open: '<big>', html_close: '</big>',
      description: 'Makes text bigger',
      example: 'The elephant was [big]really really big![/big]'
    }
  end
end
