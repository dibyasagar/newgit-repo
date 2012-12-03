CQ.wcm.SiteStatistics=CQ.Ext.extend(CQ.Ext.Viewport,{eastPanelHidden:null,westPanelHidden:null,westPanelBtn:null,eastPanelBtn:null,eastPanel:null,westPanel:null,containerPanel:null,viewport:null,tab1:null,tab2:null,detail2:null,invDetailPanel:null,mainTabPanel:null,detailsPanel:null,centerPanel:null,constructor:function(b){var a=CQ.Ext.getBody();
a.setStyle("margin","0");
if(CQ.Ext.isIE){a.dom.scroll="no"
}else{a.setStyle("overflow","hidden")
}try{}catch(c){var d=10
}this.fooPanel=new CQ.Workflow.Console.InboxPanel({});
this.centerPanel=new CQ.Ext.TabPanel({region:"center",activeTab:0,items:[{title:"Site Information",xtype:"panel",id:"cq.wcm.sitestats",height:"700",layout:"border",items:[{region:"north",xtype:"form",bodyStyle:"padding:15px",split:true,height:200,items:[{xtype:"pathcompletion",fieldLabel:"Foo",name:"bar"},{xtype:"textfield",fieldLabel:"Bar",name:"bar2"},{xtype:"browsefield",fieldLabel:"Browse",name:"bar10",treeRoot:{name:"/etc"}},{xtype:"textfield",fieldLabel:"FooBar",name:"bar3"}]},{region:"center",xtype:"panel",layout:"fit",height:200,items:[new CQ.Workflow.Console.InboxPanel({})]}]},{id:"cq.wcm.siteusers",title:"Active Users",xtype:"panel",html:"Hello World"},{id:"cq.wcm.replicationstats",title:"Replication Status",xtype:"panel",html:"Replication"}]});
CQ.wcm.SiteStatistics.superclass.constructor.call(this,{id:"site-statitics",layout:"border",renderTo:CQ.Util.ROOT_ID,items:[{region:"north",html:"North",xtype:"panel"},{region:"west",html:"West",xtype:"panel",title:"This is the West New Panel",autoScroll:true,containerScroll:true,collapsible:true,animCollapse:true,split:true,width:200},this.centerPanel,{region:"south",html:"South",xtype:"panel"}]})
},setRecreationActivitiesCB:function(){try{var url="/etc/recreation/activities.infinity.json";
var json=CQ.Util.eval(CQ.HTTP.get(url));
var opts=[];
for(var name in json){var activityObj=json[name];
var title=activityObj.text;
if(title){var val=activityObj.value;
opts.push({value:val,text:title})
}}opts.sort(function(l1,l2){if(l1.text<l2.text){return -1
}else{if(l1.text==l2.text){return 0
}else{return 1
}}});
this.setOptions(opts)
}catch(e){CQ.Log.error("CQ.utils.WCM#setContentLanguageOptions failed: "+e.message)
}},initComponent:function(){CQ.wcm.SiteStatistics.superclass.initComponent.call(this)
}});
CQ.Ext.reg("sitestatistics",CQ.wcm.SiteStatistics);