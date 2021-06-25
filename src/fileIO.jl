module fileIO
function mkdir_ifnot_exist(dir)
    if !isdir(dir)
        mkdir(dir)
    end
end
function get_regexfile(r)
    file_list = readdir()
    file_r = file_list[map(x->occursin(r,x), file_list)]
    return file_r
end
function get_current(file)
    m = match(r"([0-9]*)mA",file)
    return parse(Int,m.captures[1])
end
function get_txtfile()
    file_list = readdir()
    file_txt = file_list[map(x->occursin(r"\.txt$",x), file_list)]
    return file_txt
end
function get_tiffile()
    file_list = readdir()
    file_tif = file_list[map(x->occursin(r"\.tif$",x), file_list)]
    current = get_current.(file_tif)
    file_tif = file_tif[sortperm(current)]
    return file_tif
end
function get_csvfile()
    file_list = readdir()
    file_csv = file_list[map(x->occursin(r"MPC.*\.csv$",x), file_list)]
    current = get_current.(file_csv)
    file_csv = file_csv[sortperm(current)]
    return file_csv
end
function get_foldername()
    file_list = readdir()
    folder_list = file_list[map(x->!(occursin(r"\.",x)),file_list)]
    return folder_list
end
function get_MPCfoldername()
    file_list = readdir()
    folder_list = file_list[map(x->!(occursin(r"\.",x)),file_list)]
    mpcfolder_list = folder_list[map(x->(occursin(r"^MPC",x)),folder_list)]
    return mpcfolder_list
end
function get_sorted_spectrum_data()
    txt_list = get_txtfile()
    current_list = get_current_from_file(txt_list)
    sorted_txt_list= txt_list[sortperm(current_list)]
    current_list= current_list[sortperm(current_list)]
    return sorted_txt_list, current_list
end
end # module
