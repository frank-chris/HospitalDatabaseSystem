def nested_list_to_html_table(table:list, buttons:bool = False):
    '''
    Helper function to convert a list of lists into an html table
    table: list of lists to be converted into an html table
    button: boolean variable denoting whether there are buttons

    Return
    html_string: The corresponding table in html format as a string
    '''
    columns = table[0]
    html_string = '<thead><tr><th></th>'

    for col in columns:
        html_string += "<th>" + str(col) + "</th>"

    html_string += "</tr></thead><tbody>"

    for i, row in enumerate(table[1:]):
        html_string += "<tr>"
        if buttons:
            html_string += """<th><form method="post">
            <div class="tooltip" data-tip="Delete"><button name='delete_button' value='""" + ','.join([str(x) for x in row]) +"""' class='btn btn-sm btn-primary btn-circle p-1'>
            <svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6' fill='none' viewBox='0 0 24 24' stroke='currentColor' stroke-width='2'>
            <path stroke-linecap='round' stroke-linejoin='round' d='M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16' />
            </svg></button></div>
            <div class="tooltip" data-tip="Update"><button name='update_button' value='""" + ','.join([str(x) for x in row]) +"""' class='btn btn-sm btn-primary btn-circle p-1'>
            <svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6' fill='none' viewBox='0 0 24 24' stroke='currentColor' stroke-width='2'>
            <path stroke-linecap='round' stroke-linejoin='round' d='M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z' />
            </svg></button></div></form></th>
            """
        else:
            html_string += "<th>" + str(i+1) + "</th>"

        for cell in row:
            html_string += "<td>" + str(cell) + "</td>"

        html_string += "</tr>"

    html_string += "</tbody>"

    return html_string
    

def nested_list_to_html_select(nested_list:list):
    '''
    Helper function to convert a list of lists into an html select tag
    nested_list: list of lists to be converted into an html select tag

    Return
    select_string: The corresponding select tag in html format as a string
    '''
    select_string = "<option disabled selected>Pick a table</option>" 
    
    for sub_list in nested_list[1:]:
        for option in sub_list:
            select_string += "<option>" + str(option) + "</option>"

    return select_string

def get_insert_form(columns:list):
    '''
    Create an insert form string out of column names
    columns: list containing the column names

    Return
    form_string: String containing the insert form
    '''
    form_string = ""

    for col_name in columns:
        form_string += "<input type='text' name='" + str(col_name) + "' placeholder='" + str(col_name) + "' class='input input-bordered' required>"

    return form_string

def get_update_form(columns:list, values:list):
    '''
    Create an update form string out of column names
    columns: list containing the column names

    Return
    form_string: String containing the update form
    '''
    form_string = ""

    for col, val in zip(columns, values):
        form_string += "<div class='form-control'><label class='label'><span class='label-text'>" + str(col) +"</span></label><input type='text' name='" + str(col) + "' placeholder='" + str(col) + "' class='input input-bordered' value='" + str(val) + "' required></div>"

    return form_string