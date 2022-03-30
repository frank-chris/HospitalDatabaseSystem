
def nested_list_to_html_table(table:list):
    columns = table[0]
    html_string = "<thead><tr><th></th>"

    for col in columns:
        html_string += "<th>" + str(col) + "</th>"

    html_string += "</tr></thead><tbody>"

    for i, row in enumerate(table[1:]):
        html_string += "<tr>"
        html_string += "<th>" + str(i+1) + "</th>"

        for cell in row:
            html_string += "<td>" + str(cell) + "</td>"

        html_string += "</tr>"

    html_string += "</tbody>"

    return html_string