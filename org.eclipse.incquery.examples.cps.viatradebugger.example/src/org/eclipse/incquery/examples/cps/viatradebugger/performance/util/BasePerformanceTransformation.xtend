package org.eclipse.incquery.examples.cps.viatradebugger.performance.util

import org.eclipse.viatra.query.runtime.api.ViatraQueryEngine
import org.eclipse.viatra.examples.cps.traceability.CPSToDeployment
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.EventDrivenTransformation
import org.eclipse.viatra.examples.cps.xform.m2m.incr.viatra.patterns.CpsXformM2M
import org.eclipse.viatra.query.runtime.emf.EMFScope
import org.eclipse.viatra.query.runtime.api.AdvancedViatraQueryEngine
import org.eclipse.viatra.transformation.evm.specific.resolver.FixedPriorityConflictResolver
import org.eclipse.viatra.transformation.evm.api.ExecutionSchema
import org.eclipse.viatra.examples.cps.xform.m2m.incr.viatra.rules.RuleProvider

abstract class BasePerformanceTransformation{
	protected ViatraQueryEngine engine
	CPSToDeployment cps2dep
	protected EventDrivenTransformation transform
	protected extension CpsXformM2M queries = CpsXformM2M.instance
	protected extension RuleProvider ruleProvider
	
	//Initialize model transformation
	def initialize(CPSToDeployment cps2dep) {
		//Load the model to be transformed
		this.cps2dep = cps2dep
		//Create EMF scope and EMF IncQuery engine based on the loaded model
		val scope = new EMFScope(cps2dep.eResource.getResourceSet())
		engine = AdvancedViatraQueryEngine.createUnmanagedEngine(scope);	
		prepare(engine)
		//Create rule provider that defines transformation rules
		ruleProvider = new RuleProvider(engine, cps2dep)
		
		//Create and start model transformation
		transform = EventDrivenTransformation.forEngine(engine)
			.setSchema(createExecutionSchema)
			.addRule(hostRule)
			.addRule(applicationRule)
			.addRule(stateMachineRule)
			.addRule(stateRule)
			.addRule(transitionRule)
			.addRule(triggerRule)
			.build()
		afterTransformationInit
		transform.executionSchema.startUnscheduledExecution
	}
	//Dispose model transformation
	def dispose() {
		if (transform != null) {
			transform.executionSchema.dispose
		}
		transform = null
		return
	}
	//Create a conflict resolver that establishes a priority order among transformation rules
	def FixedPriorityConflictResolver createConflictResolver(){
		val fixedPriorityResolver = new FixedPriorityConflictResolver
		fixedPriorityResolver.setPriority(hostRule.ruleSpecification, 1)
		fixedPriorityResolver.setPriority(applicationRule.ruleSpecification, 2)
		fixedPriorityResolver.setPriority(stateMachineRule.ruleSpecification, 3)
		fixedPriorityResolver.setPriority(stateRule.ruleSpecification, 4)
		fixedPriorityResolver.setPriority(transitionRule.ruleSpecification, 5)
		fixedPriorityResolver.setPriority(triggerRule.ruleSpecification, 6)
		return fixedPriorityResolver
	}
	//Create the Execution Schema of the model transformation
	def abstract ExecutionSchema createExecutionSchema()
	//Execute functionality after the transformation has been initialized
	def void afterTransformationInit() {}
}