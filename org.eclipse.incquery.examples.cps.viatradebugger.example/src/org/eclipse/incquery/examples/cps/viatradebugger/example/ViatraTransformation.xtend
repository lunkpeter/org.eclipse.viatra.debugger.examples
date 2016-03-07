package org.eclipse.incquery.examples.cps.viatradebugger.example

import org.eclipse.incquery.examples.cps.traceability.CPSToDeployment
import org.eclipse.incquery.examples.cps.xform.m2m.incr.viatra.patterns.CpsXformM2M
import org.eclipse.incquery.examples.cps.xform.m2m.incr.viatra.rules.RuleProvider
import org.eclipse.incquery.runtime.api.AdvancedIncQueryEngine
import org.eclipse.incquery.runtime.api.IncQueryEngine
import org.eclipse.incquery.runtime.emf.EMFScope
import org.eclipse.incquery.runtime.evm.api.Executor
import org.eclipse.incquery.runtime.evm.specific.resolver.FixedPriorityConflictResolver
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.EventDrivenTransformation
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.ExecutionSchemaBuilder

public class ViatraTransformation{
	IncQueryEngine engine
	CPSToDeployment cps2dep
	EventDrivenTransformation transform
	extension CpsXformM2M queries = CpsXformM2M.instance
	extension RuleProvider ruleProvider
	Executor executor
	
	new(CPSToDeployment cps2dep){
		this.cps2dep = cps2dep
		//Create EMF scope and EMF IncQuery engine based on the loaded model
		val scope = new EMFScope(cps2dep.eResource.getResourceSet())
		
		engine = AdvancedIncQueryEngine.createUnmanagedEngine(scope);	
		prepare(engine)
		
		//Create rule provider that defines transformation rules
		ruleProvider = new RuleProvider(engine, cps2dep)
	}
	//Initialize model transformation
	def initialize() {		
		//Create execution schema
		val schema= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver).build()

		//Create and start model transformation
		transform = EventDrivenTransformation.forEngine(engine)
			.setSchema(schema)
			.addRule(hostRule)
			.addRule(applicationRule)
			.addRule(stateMachineRule)
			.addRule(stateRule)
			.addRule(transitionRule)
			.addRule(triggerRule)
			.build()
		
	}
	def execute(){
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
		val resolver = new FixedPriorityConflictResolver
		resolver.setPriority(hostRule.ruleSpecification, 1)
		resolver.setPriority(applicationRule.ruleSpecification, 2)
		resolver.setPriority(stateMachineRule.ruleSpecification, 3)
		resolver.setPriority(stateRule.ruleSpecification, 4)
		resolver.setPriority(transitionRule.ruleSpecification, 5)
		resolver.setPriority(triggerRule.ruleSpecification, 6)
		return resolver
	}
	
	def setExecutor(Executor executor){
		this.executor = executor
		return this
	}
	
	def getTransform(){
		return transform
	}
	
	def getEngine(){
		return engine
	}
	
	def getQueries(){
		return queries
	}
	
	def getRuleProvider(){
		return ruleProvider
	}
}