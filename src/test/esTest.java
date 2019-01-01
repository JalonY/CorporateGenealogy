import entity.TCorp;
import org.elasticsearch.action.bulk.BulkItemResponse;
import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import service.SearchCorpService;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

/**
 * @author: zsl
 * @date: 2018/06/06 15:35
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/spring-*.xml" })
public class esTest {
    @Autowired
    SearchCorpService searchCorpService;


    private TransportClient client;

    @Before
    public void before() throws UnknownHostException {
        Settings settings = Settings.builder().build();
        this.client = new PreBuiltTransportClient(settings)
                .addTransportAddress(new TransportAddress(InetAddress.getByName("39.108.71.221"), 9300));
    }

    @After
    public void after() {
        this.client.close();
    }

    @Test
    public void addTest() {
        List<TCorp> allCorpNames = searchCorpService.getAllCorpName();
        for (TCorp allCorpName : allCorpNames) {
            //deleteByName(allCorpName.getCorpName());
            add(allCorpName.getCorpName());
        }
    }

    public void add(String name) {
        try {
            XContentBuilder content = XContentFactory.jsonBuilder()
                    .startObject()
                    .field("name", name)
                    .endObject();

            IndexResponse result = this.client.prepareIndex("medcl", "folks")
                    .setSource(content)
                    .get();
            System.out.println(result.getId());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void deleteByName(String name){
        BulkRequestBuilder bulkRequest = client.prepareBulk();
        SearchResponse response = client.prepareSearch("medcl").setTypes("folks")
                .setSearchType(SearchType.DFS_QUERY_THEN_FETCH)
                .setQuery(QueryBuilders.termQuery("name", name))
                .setFrom(0).setSize(20).setExplain(true).execute().actionGet();
        for(SearchHit hit : response.getHits()){
            String id = hit.getId();
            bulkRequest.add(client.prepareDelete("medcl", "folks", id).request());
        }
        BulkResponse bulkResponse = bulkRequest.get();

        if (bulkResponse.hasFailures()) {
            for(BulkItemResponse item : bulkResponse.getItems()){
                System.out.println(item.getFailureMessage());
            }
        }else {
            System.out.println("delete ok");
        }
    }

}
