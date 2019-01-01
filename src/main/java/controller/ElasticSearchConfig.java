package controller;

import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 在Tomcat运行时才会自动注入
 *
 * @author: zsl
 * @date: 2018/06/03 15:09
 */
@Configuration
public class ElasticSearchConfig {

    @Bean
    public TransportClient client() throws UnknownHostException {
        Settings settings = Settings.builder().build();
        TransportClient client = new PreBuiltTransportClient(settings)
                .addTransportAddress(new TransportAddress(InetAddress.getByName("39.108.71.221"), 9300));
        return client;
    }
}
