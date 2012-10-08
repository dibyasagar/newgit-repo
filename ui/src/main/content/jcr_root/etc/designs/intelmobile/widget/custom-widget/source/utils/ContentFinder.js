CQ.utils.wcm={};
CQ.utils.wcm.ContentFinder=function(){return{getBrowseTree:function(config,treeID,resultBoxID){if(!config.treeRoot){config.treeRoot=new Object()
}this.treeRootConfig=CQ.Ext.applyIf(config.treeRoot,{name:"content/dam",text:CQ.I18n.getMessage("Media"),draggable:false,expanded:true});
if(!config.treeLoader){config.treeLoader=new Object()
}this.treeLoaderConfig=CQ.Ext.applyIf(config.treeLoader,{baseParams:{predicate:"siteadmin"},requestMethod:"GET",dataUrl:"/bin/tree/ext.json",baseAttrs:{draggable:false,iconCls:"folder"},listeners:{beforeload:function(loader,node){this.baseParams.path=node.getPath()
}},createNode:function(attr){if(this.baseAttrs){CQ.Ext.applyIf(attr,this.baseAttrs)
}if(this.applyLoader!==false){attr.loader=this
}if(typeof attr.uiProvider=="string"){attr.uiProvider=this.uiProviders[attr.uiProvider]||eval(attr.uiProvider)
}if(attr.leaf){delete attr.leaf;
attr.children=[];
attr.expanded=true
}var node;
if(attr.leaf){node=new CQ.Ext.tree.TreeNode(attr)
}else{node=new CQ.Ext.tree.AsyncTreeNode(attr)
}return node
}});
var tree=new CQ.Ext.tree.TreePanel({id:treeID,lines:true,animate:true,enableDD:false,containerScroll:true,autoScroll:true,split:true,stateful:true,region:"north",height:220,loader:new CQ.Ext.tree.TreeLoader(this.treeLoaderConfig),root:new CQ.Ext.tree.AsyncTreeNode(this.treeRootConfig)});
tree.getSelectionModel().addListener("selectionchange",function(selModel,node){var store=CQ.Ext.getCmp(resultBoxID).items.get(0).store;
store.proxy.conn.url=node.getPath()+".media.contentfinder.json";
store.reload()
});
return tree
}}
}();