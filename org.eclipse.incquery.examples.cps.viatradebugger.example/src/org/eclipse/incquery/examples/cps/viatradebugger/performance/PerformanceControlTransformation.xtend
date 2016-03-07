package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.incquery.runtime.evm.api.ExecutionSchema
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceControlTransformation extends BasePerformanceTransformation{
	
	override ExecutionSchema createExecutionSchema(){
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setConflictResolver(createConflictResolver)
		return builder.build()
	}
}