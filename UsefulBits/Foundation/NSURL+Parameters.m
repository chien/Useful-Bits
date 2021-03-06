  //  Copyright (c) 2011, Kevin O'Neill
  //  All rights reserved.
  //
  //  Redistribution and use in source and binary forms, with or without
  //  modification, are permitted provided that the following conditions are met:
  //
  //  * Redistributions of source code must retain the above copyright
  //   notice, this list of conditions and the following disclaimer.
  //
  //  * Redistributions in binary form must reproduce the above copyright
  //   notice, this list of conditions and the following disclaimer in the
  //   documentation and/or other materials provided with the distribution.
  //
  //  * Neither the name UsefulBits nor the names of its contributors may be used
  //   to endorse or promote products derived from this software without specific
  //   prior written permission.
  //
  //  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  //  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  //  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  //  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
  //  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  //  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  //  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  //  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  //  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  //  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSURL+Parameters.h"

#import "NSDictionary+URLParams.h"

@implementation NSURL (Parameters)

+ (id)URLWithString:(NSString *)URLString parameters:(NSDictionary *)parameters;
{
  if ([parameters count] == 0)
  {
    return [NSURL URLWithString:URLString];
  }
  
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", URLString, [parameters asURLParameters]]];
}

- (NSDictionary *)queryParameters;
{
  NSArray *parameters = [[self query] componentsSeparatedByString:@"&"];
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:[parameters count]];
  
  for(NSString *parameter in parameters)
  {
    NSArray *parameter_parts = [parameter componentsSeparatedByString:@"="];
    if ([parameter_parts count] == 2)
    {
      [result setObject:[parameter_parts objectAtIndex:1] forKey:[parameter_parts objectAtIndex:0]];
    }
  }
  
  return [[result copy] autorelease];
}

@end
