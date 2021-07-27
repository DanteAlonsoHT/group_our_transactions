module GroupsHelper
  def check_image_by_group_id(group_id)
    if Group.all.where(id: group_id).first.icon.persisted?
      link_to image_tag(Group.all.where(id: group_id).first.icon), groups_path
    else
      link_to image_tag('http://a4.mzstatic.com/us/r1000/046/Purple/bd/8f/fd/mzl.emkswtfe.jpg'), groups_path
    end
  end
end
