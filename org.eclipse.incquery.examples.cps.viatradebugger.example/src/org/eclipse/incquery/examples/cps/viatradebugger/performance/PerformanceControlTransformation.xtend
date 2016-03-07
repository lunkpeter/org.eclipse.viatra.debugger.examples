package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.viatra.transformation.evm.api.ExecutionSchema
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceControlTransformation extends BasePerformanceTransformation{
	
	override ExecutionSchema createExecutionSchema(){
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setConflictResolver(createConflictResolver)
		return builder.build()
	}
}