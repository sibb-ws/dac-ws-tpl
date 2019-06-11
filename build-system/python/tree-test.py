import os
import yaml
import shutil


def many_to_one(base_path: str, md_sources_root:str, data_dict: {}, main_file:str):
    """
    supports only one level of depth of folder structure
    :param base_path:
    :param data_dict:
    :param main_file:
    :return:
    """
    main_file_name = base_path + '/' + main_file + '.md'
    main_file_content = ''
    main_file_content_array = []
    for chapter_name, file_name_list in data_dict.items():
        for file_name in file_name_list:
            print(chapter_name, "->\t", file_name)
            file_name = md_sources_root+ '/' + chapter_name + '/' + file_name + '.md'
            with open(file_name, 'r', encoding='utf-8') as md:
                for read_line in md.readlines():
                    main_file_content_array.append(read_line)
                main_file_content_array.append('\n') # todo remove
                md.close()

    for array_line in main_file_content_array:
        main_file_content += array_line

    with open(main_file_name, 'w', encoding='utf-8') as main:
        main.write(main_file_content)
        main.close()


if __name__=='__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Join many to one markdowns')
    parser.add_argument('--base_path', metavar='base_path', type=str,
                        help='path with ending slash')
    parser.add_argument('--mapping', metavar='mapping', type=str,
                        help='YAML file path with the folder structure')

    parser.add_argument('--output_file_name', metavar='output_file_name',type=str,help='name of the merged file without extension')
    parser.add_argument('--md_sources_root', metavar='md_sources_root',type=str,help='name of the root path to the splitted markdown')
    args = parser.parse_args()

    mapping = open(args.mapping, "r", encoding="utf-8")

    mapping_load = yaml.load(mapping)

    mapping.close()

    many_to_one(args.base_path, args.md_sources_root, mapping_load['files'], str(args.output_file_name))
