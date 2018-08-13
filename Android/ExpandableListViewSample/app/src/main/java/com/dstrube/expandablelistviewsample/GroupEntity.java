package com.dstrube.expandablelistviewsample;

import java.util.ArrayList;
import java.util.List;

/**
 * Created on 6/11/2014.
 */
public class GroupEntity {
    public String Name;
    public List<GroupItemEntity> GroupItemCollection;

    public GroupEntity()
    {
        GroupItemCollection = new ArrayList<>();
    }

    public class GroupItemEntity
    {
        public String Name;
    }

}
