/**
 * 
 */
package com.intel.mobile.services.impl;


import java.util.Map;
import java.util.Set;

import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.jcr.api.SlingRepository;
import org.apache.sling.settings.SlingSettingsService;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.FrameworkUtil;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.services.IntelConfigurationService;
import com.intel.mobile.services.NotificationService;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.SchedulerService;
import com.intel.mobile.sync.ProductTypesSyschronizer;
import com.intel.mobile.sync.ProductsSynchronizer;
import com.intel.mobile.util.RepoUtil;
import com.intel.mobile.vo.SyncMessageVO;

/**
 * @author skarm1
 *
 */

@Component (immediate=true, label="Intel Shop API Scheduler", description = " Intel Shop API Scheduler", metatype=true )
@Service 
@Properties({
	@Property(name = Constants.SERVICE_DESCRIPTION, value = "Intel Scheduler Service"),
	@Property(name = Constants.SERVICE_VENDOR, value = "Intel"),
	//@Property(name = "run.modes", value="author", cardinality = 2),
	@Property(name = "scheduler.concurrent",  boolValue=false),
	@Property(name = "scheduler.expression", value = "0 * * */7 * ?" , description = "Scheduler Cron Expression. Follow the link http://www.docjar.com/docs/api/org/quartz/CronExpression.html for more details.")})


	public class ShopSchedulerServiceImpl implements SchedulerService,Runnable {



	private static final Logger LOG = LoggerFactory.getLogger(ShopSchedulerServiceImpl.class);

	@Reference
	private SlingRepository repository;

	
	
	private Session jcrSession;

	public void run() {

		LOG.info("Executing a cron job (job#1) for intel SHOP API sync with CQ");
		SyncMessageVO messages = new SyncMessageVO();
		try {

			BundleContext bundleContext = FrameworkUtil.getBundle(SlingSettingsService.class).getBundleContext();  
			IntelConfigurationService intelConfigService = (IntelConfigurationService) bundleContext.getService(bundleContext.getServiceReference(IntelConfigurationService.class.getName()));
			if(intelConfigService.isSyncJobDisabled())
			{
				LOG.info("*** Intel Shop Sync Job is disabled ***");
				return;
			}
			SlingSettingsService slingSettingsService = (SlingSettingsService) bundleContext.getService(bundleContext.getServiceReference(SlingSettingsService.class.getName()));	
			NotificationService notificationService = (NotificationService) bundleContext.getService(bundleContext.getServiceReference(NotificationService.class.getName()));
			Set<String> runModes = slingSettingsService.getRunModes();
			LOG.debug("Run Modes :"+runModes);
			if(runModes!=null && runModes.contains(IntelMobileConstants.RUN_MODE_AUTHOR)){
				LOG.debug("repository :"+repository);
				jcrSession = RepoUtil.login(repository);
				Map<String, String> productTypesMap = new ProductTypesSyschronizer().syncProductTypes(jcrSession, messages);
				notificationService.notifyErrorMessages(messages.getFailureList(), "Product Types Synchronizer Service");
				notificationService.notifySuccessMessages(messages.getSuccessList(), "Product Types Synchronizer Service");
				messages = null;
				messages = new SyncMessageVO();							
				new ProductsSynchronizer().syncProducts(jcrSession,productTypesMap, messages);
				notificationService.notifyErrorMessages(messages.getFailureList(), "Products Synchronizer Service");
				notificationService.notifySuccessMessages(messages.getSuccessList(), "Products Synchronizer Service");										
				jcrSession.logout();
			}else{
				LOG.debug("The service will only run in author mode.Skip the execution.");
			}

		} catch (PathNotFoundException e) {
			LOG.error("PathNotFoundException :", e);
		}catch (RepositoryException e) {
			LOG.error("RepositoryException :", e);
		} 

	}

	protected void activate(ComponentContext context){

	}

}
